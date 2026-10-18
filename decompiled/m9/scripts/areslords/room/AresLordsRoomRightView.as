package areslords.room
{
   import areslords.room.right.AresLordsSkillView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.AresLordsEvent;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.areslords.AresLordsModel;
   import mvc.module.areslords.AresLordsRoomInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.AresLordsManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.SimpleAlertHelper;
   
   public class AresLordsRoomRightView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _title:Image;
      
      private var _skillTitle:Image;
      
      private var _pointTitle:Image;
      
      private var _pointTxt:FilterFrameText;
      
      private var _countTitle:Image;
      
      private var _countTxt:FilterFrameText;
      
      private var _buyTipTxt:FilterFrameText;
      
      private var _allSkillBtn:IconButton;
      
      private var _changeBtn:IconButton;
      
      private var _skillBox:HBox;
      
      private var _clickTime:int;
      
      private var _model:AresLordsModel = AresLordsManager.instance.model;
      
      private var _cost:int = ConfigInfoManager.instance.getAresRefreshSkillCost();
      
      private var _freeCount:int;
      
      public function AresLordsRoomRightView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightBgBorder");
         _title = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightTitle");
         _skillTitle = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightSkillTitle");
         _pointTitle = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightPointTitle");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightPointTxt");
         _countTitle = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightCountTitle");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightCountTxt");
         _buyTipTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightBuyTipTxt");
         _allSkillBtn = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightAllSkillBtn");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightChangeBtn");
         _skillBox = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightSkillBox");
         addChild(_bg);
         addChild(_title);
         addChild(_skillTitle);
         addChild(_pointTitle);
         addChild(_pointTxt);
         addChild(_countTitle);
         addChild(_countTxt);
         addChild(_buyTipTxt);
         addChild(_allSkillBtn);
         addChild(_changeBtn);
         addChild(_skillBox);
         _allSkillBtn.text = LanguageMgr.GetTranslation("areslords.Room.Right.str03");
      }
      
      private function addEvent() : void
      {
         _allSkillBtn.addEventListener("click",__allSkillBtnClickHandler);
         _changeBtn.addEventListener("click",__changeBtnClickHandler);
         _model.addEventListener("AresLordsEvent.SKILL_INFO",__skillInfoHandler);
      }
      
      private function removeEvent() : void
      {
         _allSkillBtn.removeEventListener("click",__allSkillBtnClickHandler);
         _changeBtn.removeEventListener("click",__changeBtnClickHandler);
         _model.removeEventListener("AresLordsEvent.SKILL_INFO",__skillInfoHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_skillTitle);
         _skillTitle = null;
         ObjectUtils.disposeObject(_pointTitle);
         _pointTitle = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_countTitle);
         _countTitle = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_buyTipTxt);
         _buyTipTxt = null;
         ObjectUtils.disposeObject(_allSkillBtn);
         _allSkillBtn = null;
         ObjectUtils.disposeObject(_changeBtn);
         _changeBtn = null;
         ObjectUtils.disposeAllChildren(_skillBox);
         ObjectUtils.disposeObject(_skillBox);
         _skillBox = null;
         super.dispose();
      }
      
      override public function get width() : Number
      {
         return 224;
      }
      
      public function set data(param1:AresLordsRoomInfo) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:AresLordsSkillView = null;
         if(param1)
         {
            _freeCount = param1.skillInfo.freeCount;
            if(param1.skillInfo.freeCount > 0)
            {
               _buyTipTxt.text = LanguageMgr.GetTranslation("areslords.Room.Right.str01",param1.skillInfo.freeCount);
            }
            else
            {
               _buyTipTxt.text = LanguageMgr.GetTranslation("areslords.Room.Right.str02",_cost);
            }
            _pointTxt.text = param1.totalScore + "";
            _countTxt.text = param1.maxTurnCount - param1.currentTurn + "";
            _skillBox.disposeAllChildren();
            _skillBox.beginChanges();
            _loc4_ = 0;
            _loc3_ = int(param1.skillInfo.skill.length);
            while(_loc4_ < _loc3_)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightSkillView");
               _loc2_.data = param1.skillInfo.skill[_loc4_];
               _skillBox.addChild(_loc2_);
               _loc4_++;
            }
            _skillBox.commitChanges();
         }
      }
      
      private function __allSkillBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("areslords",4);
      }
      
      private function __changeBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         SoundManager.instance.play("016",true);
         var _loc4_:int = getTimer();
         if(_loc4_ - _clickTime < 3000)
         {
            return;
         }
         if(_freeCount == 0)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _cost)
            {
               RechargeAlertMannager.show();
            }
            else
            {
               SimpleAlertHelper.instance.data = [conformChange];
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc5_ = LanguageMgr.GetTranslation("public.prompt");
               _loc6_ = LanguageMgr.GetTranslation("areslords.Dialog.changeSkill",_cost);
               SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_);
            }
         }
         else
         {
            conformChange(true,false);
         }
      }
      
      private function __skillInfoHandler(param1:AresLordsEvent) : void
      {
         _clickTime = 0;
         data = param1.data as AresLordsRoomInfo;
      }
      
      private function conformChange(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            _clickTime = getTimer();
            AresLordsManager.instance.requestRefreshSkill();
         }
      }
   }
}

