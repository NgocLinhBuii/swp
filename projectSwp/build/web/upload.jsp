<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload Video to Google Cloud Storage</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            padding-top: 2rem;
            background-color: #f8f9fa;
        }
        .upload-container {
            max-width: 600px;
            margin: 0 auto;
            background-color: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .header {
            margin-bottom: 2rem;
            text-align: center;
        }
        .progress {
            display: none;
            margin-top: 1rem;
        }
        #uploadStatus {
            margin-top: 1rem;
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="upload-container">
            <div class="header">
                <h2>Upload Video</h2>
                <p class="text-muted">Upload your video to Google Cloud Storage</p>
            </div>
            
            <form action="upload-video" method="post" enctype="multipart/form-data" id="uploadForm">
                <div class="mb-3">
                    <label for="video" class="form-label">Select Video File</label>
                    <input type="file" class="form-control" id="video" name="video" accept="video/*" required>
                    <div class="form-text">Supported formats: MP4, WebM, MOV, AVI (Max size: 100MB)</div>
                </div>
                
                <div class="progress">
                    <div class="progress-bar progress-bar-striped progress-bar-animated" 
                         role="progressbar" aria-valuenow="0" aria-valuemin="0" 
                         aria-valuemax="100" style="width: 0%">0%</div>
                </div>
                
                <div id="uploadStatus" class="alert alert-info">
                    <i class="bi bi-info-circle"></i> Uploading your video...
                </div>
                
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary" id="uploadButton">
                        <i class="bi bi-cloud-upload"></i> Upload Video
                    </button>
                    <a href="LessonURL" class="btn btn-outline-secondary">Back to Lessons</a>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        document.getElementById('uploadForm').addEventListener('submit', function() {
            document.getElementById('uploadButton').disabled = true;
            document.getElementById('uploadStatus').style.display = 'block';
            document.querySelector('.progress').style.display = 'block';
            
            // Simulate progress (since actual progress tracking would require AJAX)
            let progress = 0;
            const progressBar = document.querySelector('.progress-bar');
            
            const interval = setInterval(function() {
                progress += 5;
                if (progress > 90) {
                    clearInterval(interval);
                }
                progressBar.style.width = progress + '%';
                progressBar.setAttribute('aria-valuenow', progress);
                progressBar.textContent = progress + '%';
            }, 500);
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</body>
</html> 