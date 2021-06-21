package jeju.dao.face;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jeju.dto.qna.Answer;
import jeju.dto.qna.FileTB;
import jeju.dto.qna.Hashtag;
import jeju.dto.qna.Question;
import jeju.dto.qna.Question_original;
import jeju.dto.qna.QuestionTag;

public interface QnADao {
	
	public List<HashMap<String, Object>> selectQ(HashMap<String,Object> map);
	public List<QuestionTag> selectQtag(int qstNo);
	
	
	/**
	 * 질문글 테이블 전체 조회하기
	 * 이후 추가 구현할 예정
	 * @param map 보여질 페이지 정보(한 페이지 당 5개 글 구현), 검색한 해시태그
	 * @return 조회된 질문글 전체 리스트
	 */
	public List<Map<String, Object>> selectQuestions(Map<String, Object> map);
	/**
	 * 질문글 전체 갯수 조회하기
	 * @param word 키워드로 검색한 해시태그
	 * 
	 * 
	 * @return 조회된 질문글의 게시글 갯수
	 */
	public int selectCntQustion(String word);
	/**
	 * 요청받은 번호에 해당하는 질문글 상세정보 조회하기
	 * 
	 * @param qstNo 요청받은 질문번호
	 * @return 조회한 질문글 테이블 정보
	 */
	public HashMap<String, Object> selectQuestionByqstNo(int qstNo);
	/**
	 * 요청받은 번호에 해당하는 해시태그 정보 조회하기
	 * 
	 * @param qstNo 클릭한 질문글 조회번호
	 * @return 해당 질문글에 등록된 해시태그 번호, 해시태그 이름 정보 Map
	 */
	public List<HashMap<String, Object>> selectHashTagByqstNo(int qstNo);
	/**
	 * 질문번호를 통해 조회한 질문글에 등록된 답변글의 총 갯수
	 * 
	 * @param qstNo 클릭한 질문글 번호
	 * @return 현재 등록된 답변글의 갯수
	 */
	public int selectCntAnswer(int qstNo);
	/**
	 * 요청받은 질문글 번호에 해당하는 답변글 리스트 조회하기
	 * 
	 * @param ansParam 클릭한 질문글 조회번호
	 * @return 해당 질문들에 등록된 답변글 리스트
	 */
	public List<HashMap<String, Object>> selectAnswers(Map<String, Object> ansParam);
	/**
	 * 검색한 문자열과 일치하는 태그명 갯수 조회
	 * 
	 * @param tagName 입력받은 문자열
	 * @return 조회된 태그의 갯수
	 */
	public int cntTags(String tagName);
	/**
	 * DB에 없는 태그명 새로 저장하기
	 * 
	 * @param tagName 입력받은 태그명
	 */
	public void insertTag(String tagName);
	/**
	 * DB에 저장된 태그정보 조회하기
	 * 
	 * @param tagName 입력받은 태그명
	 * @return DTO에 저장된 태그정보
	 */
	public Hashtag selectTag(String tagName);
	/**
	 * 질문글 DB에 저장하기
	 * 
	 * 
	 * @param question 요청받은 질문글 정보(제목, 작성자, 내용)
	 */
	public void insertQuestion(Question_original question);
	/**
	 * 저장한 파일 DB에 저장하기
	 * 등록한 질문글 번호를 받아 질문글과 연결하기
	 * 
	 * @param file 저장한 파일의 원본이름과 저장될 이름
	 */
	public void insertFiles(FileTB file);
	/**
	 * 질문글에 태그정보 추가하기
	 * 입력받은 태그명의 태그 번호를 받아와 DB 저장
	 * 
	 * @param map 질문글 번호, 태그번호가 담긴 map 객체
	 */
	public void insertTagIntoQustion(Map<String, Object> map);
	/**
	 * 질문글에 등록된 파일 정보 가져오기
	 * 
	 * @param file 요청받은 게시글 번호
	 * @return 질문글 번호로 저장된 파일 정보
	 */
	public List<HashMap<String, Object>> selectFiles(FileTB file);
	/**
	 * 질문글 관련 정보 삭제
	 * 
	 * @param qstNo 삭제할 질문글 번호
	 */
	public void deleteQuestion(int qstNo);
	/**
	 * 질문글 수정하기
	 * 수정된 질문글 본문 내용을 입력받아 질문 테이블 업데이트
	 * 
	 * @param question 수정하여 요청받은 질문글
	 */
	public void updateQuestion(Question question);
	/**
	 * 기존에 등록된 파일 정보 삭제
	 * 
	 * @param qstNo 수정할 게시글 번호
	 */
	public void deleteQstFiles(int qstNo);
	/**
	 * 기존에 등록된 파일 정보 삭제
	 * 
	 * @param qstNo 수정할 게시글 번호
	 */
	public void deleteAnsFiles(int ansNo);
	/**
	 * 태그정보 변경
	 * 기존의 태그 정보와 게시글과의 연결 끊기
	 * 게시글 번호에 저장된 태그 번호를 삭제하고 이후 새로운 태그정보 추가
	 * 
	 * @param qstNo 게시글 번호
	 */
	public void deleteTags(int qstNo);
	/**
	 * 상세정보 조회시 조회수 증가
	 * 
	 * @param qstNo 상제 조회할 질문글 번호
	 */
	public void updateCntQuestion(int qstNo);
	/**
	 * 답변글 생성하기
	 * 
	 * 
	 * @param answer 요청받은 답변글 정보
	 */
	public void insertAnswer(Answer answer);
	/**
	 * 답변글 삭제하기
	 * 
	 * @param ansNo 요청받은 답변글 번호
	 */
	public void deleteAnswer(FileTB ansNo);
	/**
	 * 답변글 수정하기
	 * 
	 * @param answer 변경된 답변글 정보
	 */
	public void updateAnswer(Answer answer);
	
	/**
	 * 답변글별 전체 좋아요 수 조회하기
	 * 
	 * @param answer 조회할 답변글 번호
	 * @return 조회한 좋아요 수
	 */
	public int selectCntLikes(Answer answer);
	/**
	 * 특정 답변글 좋아요 누른 여부 조회
	 * 좋아요 눌렀을 경우 1 반환, 누르지 않았을 경우 0 반환
	 * @param answer 조회할 답변글 정보
	 * @return 조회된 갯수 반환
	 */
	public int cntLiked(Answer answer);
	/**
	 * 좋아요 등록하기
	 * 
	 * @param answer 좋아요 등록할 게시글 정보
	 */
	public void insertLike(Answer answer);
	/**
	 * 좋아요 취소하기
	 * 
	 * @param answer 좋아요 취소할 게시글 정보
	 */
	public void deleteLike(Answer answer);
	/**
	 * 로그인한 유저가 작성한 질문글 갯수 조회하기
	 * 
	 * @param question 로그인한 유저 번호가 담긴 dto 객체
	 * @return 조회한 전체 질문글 갯수
	 */
	public int selectCntQuestionByuno(Question question);
	/**
	 * 로그인한 유저가 작성한 질문글 정보 조회하기
	 * 
	 * @param map 현재 로그인한 유저번호, 페이징 정보
	 * @return 조회한 질문글 리스트
	 */
	public List<HashMap<String, Object>> selectQuetionsByuno(HashMap<String, Object> map);
	/**
	 * 로그인한 유저가 작성한 답변글 갯수 조회하기
	 * 
	 * @param question 로그인한 유저 번호가 담긴 dto 객체
	 * @return 조회한 전체 답변글 갯수
	 */
	public int selectCntAnswerByuno(Answer answer);
	/**
	 * 로그인한 유저가 작성한 답변글 정보 조회하기
	 * 
	 * @param map 현재 로그인한 유저번호, 페이징 정보
	 * @return 조회한 답변글 리스트
	 */
	public List<HashMap<String, Object>> selectAnswersByuno(HashMap<String, Object> map);
	/**
	 * 로그인한 유저가 좋아요를 누른 답변글 갯수 조회하기
	 * 
	 * @param answer 로그인한 유저 번호가 담긴 dto 객체
	 * @return 조회한 전체 답변글 갯수
	 */
	public int selectCntAnsLikedByuno(Answer answer);
	/**
	 * 로그인한 유저가 좋아요를 누른 답변글 조회하기
	 * 
	 * @param map 로그인한 유저 번호, 페이징 정보
	 * @return 조회한 답변글 리스트
	 */
	public List<HashMap<String, Object>> selectAnswersLikedByuno(HashMap<String, Object> map);
	
	
}
