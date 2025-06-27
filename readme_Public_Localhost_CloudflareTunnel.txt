DO TUAN ANH - HE180507



Bước 1: Tải cloudflared.exe về máy
Mở CMD hoặc PowerShell, chạy lệnh:




winget install --id Cloudflare.cloudflared


https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-windows-amd64.exe

check:
trước khi check chạy về thư mục:

cd C:\Program Files (x86)\cloudflared

cloudflared.exe --version


Bước 2: Mở Tunnel đến localhost
Giả sử app của bạn đang chạy tại http://localhost:9999, hãy chạy lệnh sau:


cloudflared.exe tunnel --url http://localhost:9999


Cloudflare sẽ tạo 1 đường link công khai như https://something.trycloudflare.com → chia sẻ được ngay với bất kỳ ai.

