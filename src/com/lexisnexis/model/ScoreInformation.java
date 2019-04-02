package com.lexisnexis.model;

import java.util.Arrays;

public class ScoreInformation {
	
	private String quizId;
	private String[] questionId;
	private String[] choiceId;
	private String referencecode;
	private String workFlow;
	private String appname;
	private String transactionid;
	
	/**
	 * 
	 * @return
	 */

	public String getTransactionid() {
		return transactionid;
	}
	/**
	 * 
	 * @param transactionid1
	 */

	public void setTransactionid(String transactionid1) {
		this.transactionid = transactionid1;
	}

	/**
	 * @return the quizId
	 */
	public String getQuizId() {
		return quizId;
	}
	
	public String getAppname() {
		return appname;
	}
	public void setAppname(String appname1) {
		this.appname = appname1;
	}
	/**
	 * @param quizId1 the quizId to set
	 */
	public void setQuizId(String quizId1) {
		this.quizId = quizId1;
	}
	/**
	 * @return the questionId
	 */
	public String[] getQuestionId() {
		return questionId;
	}
	/**
	 * @param questionId1 the questionId to set
	 */
	public void setQuestionId(String[] questionId1) {
		this.questionId = questionId1;
	}
	/**
	 * @return the choiceId
	 */
	public String[] getChoiceId() {
		return choiceId;
	}
	/**
	 * @param choiceId1 the choiceId to set
	 */
	public void setChoiceId(String[] choiceId1) {
		this.choiceId = choiceId1;
	}
	/**
	 * @return the transactionId
	 */
	public String getReferencecode() {
		return referencecode;
	}
	/**
	 * @return the workFlow
	 */
	public String getWorkFlow() {
		return workFlow;
	}
	/**
	 * @param workFlow1 the workFlow to set
	 */
	public void setWorkFlow(String workFlow1) {
		this.workFlow = workFlow1;
	}
	/**
	 * @param transactionId the transactionId to set
	 */
	public void setReferencecode(String referencecode1) {
		this.referencecode = referencecode1;
	}
	@Override
	public String toString() {
		return "ScoreInformation [quizId=" + quizId + ", questionId=" + Arrays.toString(questionId) + ", choiceId="  //$NON-NLS-1$//$NON-NLS-2$ //$NON-NLS-3$
				+ Arrays.toString(choiceId) + ", referencecode=" + referencecode + ", workFlow=" + workFlow //$NON-NLS-1$ //$NON-NLS-2$
				+ ", appname=" + appname + ", transactionid=" + transactionid + "]"; //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$
	}

	

}
