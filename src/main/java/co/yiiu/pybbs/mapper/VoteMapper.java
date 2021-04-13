package co.yiiu.pybbs.mapper;

import co.yiiu.pybbs.vote.dao.Vote;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Service;

@Mapper
@Service
public interface VoteMapper {
    @Select("SELECT * FROM voter_vote where VID = #{VID}")
    Vote getVote(@Param("VID") Integer VID);

    @Select("SELECT VID FROM voter_vote where VID = #{VID}")
    Vote checkVote(@Param("VID") Integer VID);

    @Update("UPDATE voter_vote SET Selection = #{Selection} WHERE VID = #{VID}")
    int vote(@Param("Selection") String selection, @Param("VID") Integer VID);

    @Insert("INSERT INTO voter_vote" +
            " (Title, `Describe`, Selection, Type, `Limit`) VALUES" +
            " (#{title}, #{describe}, #{selection}, #{type}, #{limit})")
    void insertVote(@Param("title") String title, @Param("describe") String describe, @Param("selection") String selection, @Param("type") Integer type, @Param("limit") Integer limit);

    @Select("SELECT VID FROM voter_vote WHERE" +
            " Title = #{title} AND `Describe` = #{describe} AND Selection = #{selection} AND Type = #{type} AND `Limit` = #{limit}" +
            " ORDER BY VID DESC LIMIT 1")
    Integer queryVoteID(@Param("title") String title, @Param("describe") String describe, @Param("selection") String selection, @Param("type") Integer type, @Param("limit") Integer limit);
}
