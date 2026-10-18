package map.campaign.mediator.fantasymatrix
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.FantasyMatrixModel;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.TimeDownView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class FantasyMatrixRightView extends Component
   {
      
      private var rightBack:MutipleImage;
      
      private var leftTime:TimeDownView;
      
      private var helpBtn:BaseButton;
      
      private var skillVbox:VBox;
      
      private var skillList:Vector.<FantasyMatrixSkillItem>;
      
      private var boxItem:BaseItemView;
      
      private var boxCountText:FilterFrameText;
      
      private var boxInfo:GoodsInfo;
      
      public function FantasyMatrixRightView()
      {
         super();
         initView();
         initSkillView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         rightBack = ComponentFactory.Instance.creatComponentByStylename("FantasyMatrixRightView.rightBack");
         leftTime = ComponentFactory.Instance.creatComponentByStylename("FantasyMatrixRightView.leftTime");
         helpBtn = ComponentFactory.Instance.creatComponentByStylename("FantasyMatrixRightView.HelpBtn");
         skillVbox = ComponentFactory.Instance.creatComponentByStylename("FantasyMatrixRightView.skillVbox");
         boxItem = ComponentFactory.Instance.creatCustomObject("FantasyMatrixRightView.boxItem");
         boxCountText = ComponentFactory.Instance.creatComponentByStylename("FantasyMatrixRightView.boxCountText");
         addChild(rightBack);
         addChild(leftTime);
         addChild(helpBtn);
         addChild(skillVbox);
         addChild(boxItem);
         addChild(boxCountText);
         helpBtn.tipData = LanguageMgr.GetTranslation("vehicle.helpFrame1.title");
         boxInfo = new GoodsInfo();
         boxInfo.templateId = 2131515;
         boxItem.data = boxInfo;
      }
      
      private function initSkillView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:FantasyMatrixSkillItem = null;
         skillList = new Vector.<FantasyMatrixSkillItem>();
         _loc1_ = 1;
         while(_loc1_ <= 3)
         {
            _loc2_ = new FantasyMatrixSkillItem();
            _loc2_.skillId = _loc1_;
            skillVbox.addChild(_loc2_);
            skillList.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function addEvent() : void
      {
         helpBtn.addEventListener("click",__helpClickHandler);
      }
      
      private function removeEvent() : void
      {
         helpBtn.removeEventListener("click",__helpClickHandler);
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("fantasyMatrix.FantasyMatrixRightView.helpFrame");
         _loc2_.show();
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:FantasyMatrixSkillItem = null;
         leftTime.timeCount = model.leftTime;
         if(!model.isStart)
         {
            leftTime.stopTimer();
         }
         else if(model.leftTime > 0)
         {
            leftTime.start();
         }
         boxCountText.text = "x" + model.hasBoxCount;
         _loc1_ = 1;
         while(_loc1_ <= 3)
         {
            _loc2_ = skillList[_loc1_ - 1];
            _loc2_.refreshView();
            _loc1_++;
         }
      }
      
      private function get model() : FantasyMatrixModel
      {
         return CampaignManager.instance.fantasyMatrixModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(rightBack);
         rightBack = null;
         ObjectUtils.disposeObject(leftTime);
         leftTime = null;
         ObjectUtils.disposeObject(boxItem);
         boxItem = null;
         ObjectUtils.disposeObject(helpBtn);
         helpBtn = null;
         ObjectUtils.disposeObject(boxCountText);
         boxCountText = null;
         ObjectUtils.disposeObject(skillVbox);
         skillVbox = null;
         LogicUtils.disposeDisplayCollection(skillList);
         super.dispose();
      }
   }
}

