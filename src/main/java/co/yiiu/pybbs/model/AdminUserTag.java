package co.yiiu.pybbs.model;

import lombok.Data;

/**
 * Created by Noahhhhha
 * on 2021/3/24 15:28.
 */
@Data
public class AdminUserTag {
    private static final long serialVersionUID = 1L;
    private Integer adminUserId;
    private Integer tagId;
}
