## Mini Project: Private S3 Access via Access Point

### Architecture
IAM User → S3 Access Point → S3 Bucket
                    ↑
             S3 Gateway Endpoint (VPC)

### What I built
- Private S3 bucket with SSE-S3
- S3 Access Point with restrictive policy
- VPC with private subnet
- S3 Gateway Endpoint attached to route table
- Access restricted to VPC using aws:SourceVpc

### Key Commands
aws s3 ls "arn:aws:s3:us-east-1:...:accesspoint/..."
aws s3api get-object --bucket "<accesspoint-arn>" --key testfile.txt output.txt

### Lessons
- Access Point policies differ from bucket policies
- Need both AP ARN and AP/object/* in resources
- VPC endpoints control *network path*, not permissions
