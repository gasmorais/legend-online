package heroroad
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.heroroad.AchievementTaskInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.AchievementTaskTemplateInfo;
   import yishi.manager.HeroRoadManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   
   public class HeroRoadAchievementItemView extends Component
   {
      
      private var _bg:Image;
      
      private var _titleTxt:FilterFrameText;
      
      private var _progressTxt:FilterFrameText;
      
      private var _rewardHbox:HBox;
      
      private var _notAchieve:Image;
      
      private var _getBtn:IconButton;
      
      private var _hasGetBtn:IconButton;
      
      private var _data:AchievementTaskInfo;
      
      public function HeroRoadAchievementItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get data() : AchievementTaskInfo
      {
         return _data;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("heroRoadAchievementItemView.bg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("heroRoadAchievementItemView.titleTxt");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("heroRoadAchievementItemView.progressTxt");
         _rewardHbox = ComponentFactory.Instance.creatComponentByStylename("heroRoadAchievementItemView.rewardHbox");
         _notAchieve = ComponentFactory.Instance.creatComponentByStylename("heroRoadAchievementItemView.notAchieve");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("heroRoadAchievementItemView.getBtn");
         _hasGetBtn = ComponentFactory.Instance.creatComponentByStylename("heroRoadAchievementItemView.hasGetBtn");
         addChild(_bg);
         addChild(_titleTxt);
         addChild(_progressTxt);
         addChild(_rewardHbox);
         addChild(_notAchieve);
         addChild(_getBtn);
         addChild(_hasGetBtn);
         _hasGetBtn.enable = false;
      }
      
      public function set data(param1:AchievementTaskInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         if(!_data.isReward && !_data.isCompleted)
         {
            _notAchieve.visible = true;
            _getBtn.visible = false;
            _hasGetBtn.visible = false;
         }
         else if(_data.isCompleted && !_data.isReward)
         {
            _notAchieve.visible = false;
            _hasGetBtn.visible = false;
            _getBtn.visible = true;
         }
         else
         {
            _notAchieve.visible = false;
            _hasGetBtn.visible = true;
            _getBtn.visible = false;
         }
         var _loc2_:AchievementTaskTemplateInfo = TempleteManager.instance.achievementTaskTemplateCate.getTemplateByID(_data.templateId);
         if(_loc2_)
         {
            _titleTxt.htmlText = _loc2_.ConditionTitle;
            _progressTxt.text = "(" + _data.data + "/" + _loc2_.ConditionParm2 + ")";
            _progressTxt.x = _titleTxt.x + _titleTxt.textWidth + 5;
            refrehshHox(_loc2_.Rewards);
         }
      }
      
      private function disposeRewardHbox() : void
      {
         var _loc1_:Sprite = null;
         while(_rewardHbox.numChildren > 0)
         {
            _loc1_ = _rewardHbox.getChildAt(0) as Sprite;
            if(_loc1_)
            {
               ObjectUtils.disposeAllChildren(_loc1_);
               if(_loc1_.parent)
               {
                  _loc1_.parent.removeChild(_loc1_);
               }
            }
         }
      }
      
      private function refrehshHox(param1:String) : void
      {
         var _loc2_:BaseItemView = null;
         var _loc4_:Image = null;
         var _loc5_:Sprite = null;
         var _loc6_:int = 0;
         var _loc7_:GoodsInfo = null;
         if(StringHelper.isNullOrEmpty(param1))
         {
            return;
         }
         disposeRewardHbox();
         var _loc3_:Array = param1.split("|");
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc5_ = new Sprite();
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("heroRoadAchievementItemView.rewardItemBg");
            _loc2_ = ComponentFactory.Instance.creatCustomObject("heroRoadAchievementItemView.ItemBaseItemView");
            _loc7_ = new GoodsInfo();
            param1 = _loc3_[_loc6_];
            _loc7_.templateId = param1.split(",")[0];
            _loc7_.count = param1.split(",")[1];
            _loc2_.data = _loc7_;
            _loc5_.addChild(_loc4_);
            _loc5_.addChild(_loc2_);
            _rewardHbox.addChild(_loc5_);
            _loc6_++;
         }
      }
      
      private function addEvent() : void
      {
         if(_getBtn)
         {
            _getBtn.addEventListener("click",_getBtnClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",_getBtnClickHandler);
         }
      }
      
      private function _getBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022",false,false);
         HeroRoadManager.instance.achivementGetReward(_data.templateId);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         if(_rewardHbox)
         {
            disposeRewardHbox();
         }
         ObjectUtils.disposeObject(_rewardHbox);
         _rewardHbox = null;
         ObjectUtils.disposeObject(_notAchieve);
         _notAchieve = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_hasGetBtn);
         _hasGetBtn = null;
         super.dispose();
         _data = null;
      }
   }
}

