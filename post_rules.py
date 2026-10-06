def validate_post(title, body):
    """
    게시글 제목과 내용의 공통 입력 검사.
    앞뒤 공백을 제거한 후 제목이나 내용이 비어있는지 확인합니다.
    """
    cleaned_title = title.strip() if isinstance(title, str) else ""
    cleaned_body = body.strip() if isinstance(body, str) else ""

    if not cleaned_title or not cleaned_body:
        return False, "제목과 내용을 모두 입력해 주세요."
    return True, None
