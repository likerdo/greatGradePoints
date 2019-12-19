package springboot.web.dto;

import lombok.Getter;
import springboot.domain.posts.Posts;

import java.time.LocalDateTime;

@Getter
public class PostListResponseDto {
    private Long id;
    private String title;
    private String author;
    private LocalDateTime modifiedDateTime;

    public PostListResponseDto(Posts entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.author = entity.getAuthor();
        this.modifiedDateTime = entity.getModifiedDate();
    }
}
