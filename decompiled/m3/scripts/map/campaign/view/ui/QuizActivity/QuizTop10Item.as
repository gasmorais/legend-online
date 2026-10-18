package map.campaign.view.ui.QuizActivity
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.answerquestion.AnswerQuestionRankMsg;
   import flash.display.Sprite;
   
   public class QuizTop10Item extends Sprite implements Disposeable
   {
      
      private var _indexTxt:FilterFrameText;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _rightNumTxt:FilterFrameText;
      
      private var _job:ScaleFrameImage;
      
      private var _data:AnswerQuestionRankMsg;
      
      public var indexNum:int = 0;
      
      public function QuizTop10Item()
      {
         super();
         init();
      }
      
      public function get data() : AnswerQuestionRankMsg
      {
         return _data;
      }
      
      public function setFrame(param1:int) : void
      {
         _nickNameTxt.setFrame(param1);
         _rightNumTxt.setFrame(param1);
         _indexTxt.setFrame(param1);
      }
      
      public function set data(param1:AnswerQuestionRankMsg) : void
      {
         _data = param1;
         clean();
         if(_data)
         {
            updateView();
         }
      }
      
      private function init() : void
      {
         _job = ComponentFactory.Instance.creatComponentByStylename("quiz.rank.number");
         _indexTxt = ComponentFactory.Instance.creatComponentByStylename("quiz.rank.IndexTxt");
         addChild(_indexTxt);
         _indexTxt.text = "";
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("quiz.rank.NickNameTxt");
         addChild(_nickNameTxt);
         _nickNameTxt.text = "";
         _rightNumTxt = ComponentFactory.Instance.creatComponentByStylename("quiz.rank.rightnumtxt");
         addChild(_rightNumTxt);
         _rightNumTxt.text = "";
      }
      
      private function updateView() : void
      {
         this.visible = true;
         switch(int(_data.rank) - 1)
         {
            case 0:
               _job.setFrame(1);
               _indexTxt.visible = false;
               _job.visible = true;
               break;
            case 1:
               _job.setFrame(2);
               _indexTxt.visible = false;
               _job.visible = true;
               break;
            case 2:
               _job.setFrame(3);
               _indexTxt.visible = false;
               _job.visible = true;
               break;
            default:
               _job.visible = false;
               _indexTxt.visible = true;
         }
         if(_data.rank <= 3)
         {
            if(indexNum > _data.rank)
            {
               _job.visible = false;
            }
         }
         else if(indexNum > _data.rank)
         {
            _indexTxt.visible = false;
         }
         if(_job.parent == null)
         {
            addChild(_job);
         }
         _indexTxt.text = data.rank + ".";
         _nickNameTxt.text = data.nickName;
         _rightNumTxt.text = data.rightCount + "";
      }
      
      private function clean() : void
      {
         this.visible = false;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_nickNameTxt);
         _nickNameTxt = null;
         ObjectUtils.disposeObject(_rightNumTxt);
         _rightNumTxt = null;
         ObjectUtils.disposeObject(_indexTxt);
         _indexTxt = null;
         ObjectUtils.disposeObject(_job);
         _job = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

