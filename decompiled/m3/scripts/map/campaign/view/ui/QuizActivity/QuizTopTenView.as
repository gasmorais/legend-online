package map.campaign.view.ui.QuizActivity
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.answerquestion.AnswerQuestionPlayerMsg;
   import com.road.yishi.proto.answerquestion.AnswerQuestionRankMsg;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mainBar.StripView;
   import manager.LanguageMgr;
   
   public class QuizTopTenView extends Sprite implements Disposeable
   {
      
      private var _vBox:VBox;
      
      private var _myInfoTxt:GradientText;
      
      private var _myInfo2Txt:GradientText;
      
      private var _items:Array = [];
      
      private var _txtTitle:GradientText;
      
      private var _checkTips:StripView;
      
      public function QuizTopTenView()
      {
         super();
         initView();
         addEvent();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:QuizTop10Item = null;
         var _loc2_:MovieClip = ComponentFactory.Instance.creat("asset.quiz.bg2");
         addChild(_loc2_);
         _myInfoTxt = ComponentFactory.Instance.creatComponentByStylename("quiz.txt.myRanktxt");
         _myInfoTxt.text = LanguageMgr.GetTranslation("map.campaign.view.ui.QuizActivity.myrank",0,0,30);
         addChild(_myInfoTxt);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("quiz.Top10Vbox");
         addChild(_vBox);
         _myInfo2Txt = ComponentFactory.Instance.creatComponentByStylename("quiz.txt.myRanktxt2");
         addChild(_myInfo2Txt);
         _myInfo2Txt.text = LanguageMgr.GetTranslation("map.campaign.view.ui.QuizActivity.rightAnswer");
         _txtTitle = ComponentFactory.Instance.creatComponentByStylename("quiz.gradientTxt.title");
         addChild(_txtTitle);
         _txtTitle.text = LanguageMgr.GetTranslation("quiz.gradientTxt.title");
         _checkTips = ComponentFactory.Instance.creatCustomObject("quiz.tips");
         _checkTips.setHitArea(0,0,39,42);
         addChild(_checkTips);
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc1_ = new QuizTop10Item();
            _loc1_.data = null;
            _items[_loc3_] = _loc1_;
            _vBox.addChild(_loc1_);
            switch(_loc3_)
            {
               case 0:
                  _loc1_.setFrame(2);
                  break;
               case 1:
                  _loc1_.setFrame(3);
                  break;
               case 2:
                  _loc1_.setFrame(4);
                  break;
               default:
                  _loc1_.setFrame(5);
            }
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function show() : void
      {
         stageResizeHandler();
         y = 154;
         LayerManager.Instance.addToLayer(this,4,false,false,0,1);
      }
      
      public function stageResizeHandler() : void
      {
         x = StageReferance.stageWidth - this.width + 6;
      }
      
      public function updateMyInfoTips(param1:AnswerQuestionPlayerMsg) : void
      {
         var _loc2_:String = null;
         if(param1 == null)
         {
            _loc2_ = LanguageMgr.GetTranslation("map.campaign.view.ui.QuizActivity.myrank",0,0,30);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("map.campaign.view.ui.QuizActivity.myrank",param1.rank,param1.rightCount,param1.totalCount);
         }
         _myInfoTxt.text = _loc2_;
         _checkTips.tipData = param1;
      }
      
      public function topTenChange(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:QuizTop10Item = null;
         var _loc4_:AnswerQuestionRankMsg = null;
         if(param1)
         {
            _loc3_ = 0;
            while(_loc3_ < 10)
            {
               _loc2_ = _items[_loc3_];
               if(_loc3_ < param1.length)
               {
                  _loc4_ = param1[_loc3_];
                  _loc2_.indexNum = _loc3_ + 1;
                  _loc2_.data = _loc4_;
               }
               else
               {
                  _loc2_.data = null;
               }
               _loc3_++;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_checkTips);
         _checkTips = null;
         ObjectUtils.disposeObject(_txtTitle);
         _txtTitle = null;
         ObjectUtils.disposeObject(_myInfo2Txt);
         _myInfo2Txt = null;
         ObjectUtils.disposeObject(_myInfoTxt);
         _myInfoTxt = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_items)
         {
            for each(var _loc1_:QuizTop10Item in _items)
            {
               _loc1_.dispose();
            }
            _items = null;
         }
      }
   }
}

