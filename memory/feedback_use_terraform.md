---
name: feedback-use-terraform
description: "All infrastructure and resources must be created using Terraform code, not CLI commands"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 4c11c183-7384-4721-bf15-796a372ff562
  modified: 2026-10-05T10:26:12.601Z
---

Mọi thứ đều phải được tạo bằng Terraform (tf) code.

**Why:** User muốn quản lý infrastructure as code, đảm bảo tính nhất quán và có thể tái tạo.
**How to apply:** Khi tạo bất kỳ resource GCP nào, luôn viết Terraform code (.tf files) thay vì chạy lệnh gcloud CLI trực tiếp. Chỉ dùng gcloud CLI để kiểm tra/verify, không dùng để tạo resource.
