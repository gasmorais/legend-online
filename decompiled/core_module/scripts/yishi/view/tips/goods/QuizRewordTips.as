package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.answerquestion.AnswerQuestionPlayerMsg;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.view.tips.BaseTip;
   
   public class QuizRewordTips extends BaseTip
   {
      
      private var _rankReword:FilterFrameText;
      
      private var _gold1:FilterFrameText;
      
      private var _answerReword:FilterFrameText;
      
      private var _jingyan:FilterFrameText;
      
      private var _gold2:FilterFrameText;
      
      private var _splitLine:Bitmap;
      
      public function QuizRewordTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 100;
         _bg.height = 117;
         _rankReword = ComponentFactory.Instance.creatComponentByStylename("quiz.tips.txt1");
         addChild(_rankReword);
         _rankReword.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.quizrewordtips.rankreword");
         _gold1 = ComponentFactory.Instance.creatComponentByStylename("quiz.tips.txt2");
         addChild(_gold1);
         _answerReword = ComponentFactory.Instance.creatComponentByStylename("quiz.tips.txt3");
         addChild(_answerReword);
         _answerReword.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.quizrewordtips.answerreword");
         _jingyan = ComponentFactory.Instance.creatComponentByStylename("quiz.tips.txt4");
         addChild(_jingyan);
         _gold2 = ComponentFactory.Instance.creatComponentByStylename("quiz.tips.txt5");
         addChild(_gold2);
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine.y = 47;
         _splitLine.width = 90;
         addChild(_splitLine);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:AnswerQuestionPlayerMsg = null;
         if(tipData)
         {
            _loc1_ = tipData as AnswerQuestionPlayerMsg;
            _gold1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.quizrewordtips.gold",_loc1_.rankGolden);
            _jingyan.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.quizrewordtips.jingyan",_loc1_.exp);
            _gold2.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.quizrewordtips.gold",_loc1_.golden);
            if(_gold1.textWidth > 80)
            {
               _bg.width = _gold1.textWidth + 20;
            }
            else
            {
               _bg.width = 100;
            }
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_rankReword);
         _rankReword = null;
         ObjectUtils.disposeObject(_gold1);
         _gold1 = null;
         ObjectUtils.disposeObject(_answerReword);
         _answerReword = null;
         ObjectUtils.disposeObject(_jingyan);
         _jingyan = null;
         ObjectUtils.disposeObject(_gold2);
         _gold2 = null;
         ObjectUtils.disposeObject(_splitLine);
         _splitLine = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

