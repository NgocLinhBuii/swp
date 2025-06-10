package controller;

import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.auth.http.HttpTransportFactory;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.WriteChannel;
import com.google.cloud.http.HttpTransportOptions;
import com.google.cloud.storage.*;
import com.google.cloud.storage.Acl.Role;
import com.google.cloud.storage.Acl.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.channels.Channels;
import java.util.ArrayList;
import java.util.Arrays;

@WebServlet("/upload-video")
@MultipartConfig
public class UploadVideoServlet extends HttpServlet {

    private static final String BUCKET_NAME = "myproject-video-bucket-2025";
    private static final String CREDENTIALS_PATH = "/WEB-INF/credentials.json";
    private static Storage storage = null;

    @Override
    public void init() throws ServletException {
        try {
            String realPath = getServletContext().getRealPath(CREDENTIALS_PATH);
            if (realPath == null) {
                throw new FileNotFoundException("Credentials file not found at " + CREDENTIALS_PATH);
            }
            
            InputStream credentialsStream = new FileInputStream(realPath);
            GoogleCredentials credentials = GoogleCredentials.fromStream(credentialsStream);

            // Explicitly tell Google Cloud what HTTP transport to use.
            // This prevents it from trying to find the App Engine-specific transport.
            HttpTransportOptions transportOptions = HttpTransportOptions.newBuilder()
                .setHttpTransportFactory(new HttpTransportFactory() {
                    @Override
                    public com.google.api.client.http.HttpTransport create() {
                        return new NetHttpTransport();
                    }
                })
                .build();

            storage = StorageOptions.newBuilder()
                    .setCredentials(credentials)
                    .setTransportOptions(transportOptions) // Apply the explicit transport options
                    .build()
                    .getService();
            
            System.out.println("Google Cloud Storage client initialized successfully with explicit transport.");

        } catch (IOException e) {
            System.err.println("Failed to initialize Google Cloud Storage client.");
            e.printStackTrace();
            throw new ServletException("Could not initialize Google Cloud Storage client", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            Part filePart = request.getPart("video");
            if (filePart == null || filePart.getSize() == 0) {
                out.println("<h3>❌ Please select a video file to upload.</h3>");
                out.println("<a href='upload.jsp'>Go Back</a>");
                return;
            }
            
            String originalFileName = filePart.getSubmittedFileName();
            String objectName = "videos/" + originalFileName;

            BlobId blobId = BlobId.of(BUCKET_NAME, objectName);
            BlobInfo blobInfo = BlobInfo.newBuilder(blobId)
                .setContentType(filePart.getContentType())
                .build();

            try (WriteChannel writer = storage.writer(blobInfo);
                 OutputStream os = Channels.newOutputStream(writer);
                 InputStream is = filePart.getInputStream()) {
                
                byte[] buffer = new byte[1024 * 1024]; // 1MB buffer
                int bytesRead;
                while ((bytesRead = is.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
            }

            String publicUrl = String.format("https://storage.googleapis.com/%s/%s", BUCKET_NAME, objectName);

            out.println("<html><body>");
            out.println("<h3>✅ Upload successful!</h3>");
            out.println("<p>Video URL: <a href='" + publicUrl + "' target='_blank'>" + publicUrl + "</a></p>");
            out.println("<video width='640' controls><source src='" + publicUrl + "' type='" + filePart.getContentType() + "'></video>");
            out.println("<br/><br/><a href='upload.jsp'>Upload another video</a>");
            out.println("</body></html>");

        } catch (Exception e) {
            e.printStackTrace(out);
            out.println("<h3>❌ An error occurred during upload.</h3>");
            out.println("<p>Details: " + e.getMessage() + "</p>");
            out.println("<a href='upload.jsp'>Go Back</a>");
        }
    }
}