package sevenyear.view.battleflag
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.SevenYearManager;
   import mvc.module.sevenyear.SevenYearModel;
   import sevenyear.view.item.SevenYearAnswerItem;
   import utils.LogicUtils;
   import yishi.utils.IconFactory;
   import yishi.utils.TimerUtils;
   import yishi.view.community.BaseIconView;
   
   public class SevenYearAnswerView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _questionTxt:FilterFrameText;
      
      private var _questionIcon:BaseIconView;
      
      private var _timeTxt:FilterFrameText;
      
      private var _itemList:Vector.<SevenYearAnswerItem>;
      
      private const _timeName:String = "cdtimename";
      
      public function SevenYearAnswerView()
      {
         super();
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("SevenYearAnswerView.bg");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearAnswerView.scoreTxt");
         _questionTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearAnswerView.questionTxt");
         _questionIcon = ComponentFactory.Instance.creatCustomObject("SevenYearAnswerView.questionIcon");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearAnswerView.timeTxt");
         addChild(_bg);
         addChild(_scoreTxt);
         addChild(_questionTxt);
         addChild(_questionIcon);
         addChild(_timeTxt);
         initAnswer();
      }
      
      private function initAnswer() : void
      {
         var _loc1_:SevenYearAnswerItem = null;
         var _loc2_:int = 0;
         _itemList = new Vector.<SevenYearAnswerItem>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new SevenYearAnswerItem(_loc2_);
            _loc1_.x = 7 + 105 * (int(_loc2_ % 2));
            _loc1_.y = 130 + 60 * (int(_loc2_ / 2));
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function refreshView() : void
      {
         refreshScore();
         if(model.questionTempInfo)
         {
            _questionTxt.text = model.questionTempInfo.TemplateName;
            if(model.questionTempInfo.IconPath)
            {
               _questionIcon.icon = IconFactory.getSevenYearIconPath(model.questionTempInfo.IconPath);
            }
            else
            {
               _questionIcon.icon = null;
            }
         }
         for each(var _loc1_:SevenYearAnswerItem in _itemList)
         {
            _loc1_.refreshView();
         }
         TimerUtils.removeSecendTimer("cdtimename");
         TimerUtils.addSecendTimer("cdtimename",1,model.cdTime,refreshTime);
      }
      
      public function refreshScore() : void
      {
         _scoreTxt.text = LanguageMgr.GetTranslation("SevenYearAnswerView.scoreTxt.text",model.answerTotalScore);
      }
      
      private function refreshTime() : void
      {
         var _loc1_:int = int(TimerUtils.getTime("cdtimename"));
         _timeTxt.text = LanguageMgr.GetTranslation("SevenYearAnswerView.timeTxt.text",_loc1_);
      }
      
      public function removeClick() : void
      {
         if(_itemList == null)
         {
            return;
         }
         for each(var _loc1_:SevenYearAnswerItem in _itemList)
         {
            _loc1_.remove();
         }
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      override public function dispose() : void
      {
         TimerUtils.removeSecendTimer("cdtimename");
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_questionTxt);
         _questionTxt = null;
         ObjectUtils.disposeObject(_questionIcon);
         _questionIcon = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         super.dispose();
      }
   }
}

