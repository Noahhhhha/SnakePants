package co.yiiu.pybbs.vote.dao;

import lombok.Data;
@Data
public class Vote {
    private Integer vId;
    private String title;
    private String describe;
    private String selection;
    private Integer type;
    private Integer limit;
    private Integer userId;
}
