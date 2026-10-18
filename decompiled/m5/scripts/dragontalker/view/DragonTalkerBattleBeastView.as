package dragontalker.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dragontalker.item.DragonTalkerBattleBeastPropItem;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.DragonTalkerFightMountTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BulePowerItem;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerBattleBeastView extends Component
   {
      
      private var _back:MutipleImage;
      
      private var _nameText:FilterFrameText;
      
      private var _mountAvatar:BattleBeastShowAvatarView;
      
      private var _changeBtn:IconButton;
      
      private var _curPropItem:DragonTalkerBattleBeastPropItem;
      
      private var _nextPropItem:DragonTalkerBattleBeastPropItem;
      
      private var _trainCountText:FilterFrameText;
      
      private var _beastCountText:FilterFrameText;
      
      private var _trainBtn:BaseButton;
      
      private var _expBar:BulePowerItem;
      
      private var _addExpText:FilterFrameText;
      
      private var mountMaterialId:int;
      
      private var materialExp:int;
      
      private var selectTempId:int;
      
      private var hasMaterialCount:int;
      
      public function DragonTalkerBattleBeastView()
      {
         super();
         mountMaterialId = ConfigInfoManager.instance.getDragonTalkerInfoUpgradeConfig()[2];
         materialExp = ConfigInfoManager.instance.getDragonTalkerInfoUpgradeConfig()[3];
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _trainCountText = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n5_ppj0ppj01i");
         _beastCountText = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n4_ppj0ppj01i");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n1_ppj0ppj01i");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.ppj01i.changeBtn");
         _trainBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.ppj01i.trainBtn");
         _back = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.ppj01i.back");
         _mountAvatar = ComponentFactory.Instance.creatCustomObject("DragonTalkerBattleBeastView.mountAvatar");
         _expBar = ComponentFactory.Instance.creatCustomObject("DragonTalkerBattleBeastView.expBar",[true]);
         _curPropItem = ComponentFactory.Instance.creatCustomObject("DragonTalkerBattleBeastView.curPropContiner",[1]);
         _nextPropItem = ComponentFactory.Instance.creatCustomObject("DragonTalkerBattleBeastView.nextPropContiner",[2]);
         _addExpText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerBattleBeastView.addExpText");
         addChild(_back);
         addChild(_nameText);
         addChild(_mountAvatar);
         addChild(_changeBtn);
         addChild(_curPropItem);
         addChild(_nextPropItem);
         addChild(_beastCountText);
         addChild(_trainCountText);
         addChild(_expBar);
         addChild(_addExpText);
         addChild(_trainBtn);
         _trainCountText.text = "1";
         _mountAvatar.mouseChildren = _mountAvatar.mouseEnabled = false;
         this.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         _changeBtn.addEventListener("click",clickchangeBtnHandler);
         _trainBtn.addEventListener("click",clicktrainBtnHandler);
         _trainCountText.addEventListener("change",__textChangHandler);
         MsgMan.addObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateBattleBeastInfo);
      }
      
      private function removeEvent() : void
      {
         if(_changeBtn)
         {
            _changeBtn.removeEventListener("click",clickchangeBtnHandler);
         }
         if(_trainBtn)
         {
            _trainBtn.removeEventListener("click",clicktrainBtnHandler);
         }
         if(_trainCountText)
         {
            _trainCountText.removeEventListener("change",__textChangHandler);
         }
         MsgMan.removeObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateBattleBeastInfo);
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_trainCountText.text);
         if(_loc2_ <= 0)
         {
            _trainCountText.text = "1";
         }
         var _loc3_:int = Math.min(hasMaterialCount,9999);
         if(_loc2_ >= _loc3_)
         {
            _trainCountText.text = _loc3_ + "";
         }
         _addExpText.text = "+" + materialExp * int(_trainCountText.text);
      }
      
      private function __updateBattleBeastInfo(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function clicktrainBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = parseInt(_trainCountText.text);
         if(_loc2_ <= 0 || _loc2_ > hasMaterialCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsRightSkillView.train.noGoodsAlert"));
            return;
         }
         DragonTalkerManager.instance.sendFightMountStrengthReq(_loc2_);
      }
      
      private function clickchangeBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("dragontalker","BATTLE_BEAST_PREVIEW_FRAME");
      }
      
      private function refreshView() : void
      {
         var _loc1_:Boolean = false;
         if(selectTempId != model.selectBattleBeastId)
         {
            _loc1_ = true;
         }
         selectTempId = model.selectBattleBeastId;
         var _loc4_:DragonTalkerFightMountTempInfo = TempleteManager.instance.dragonTalkerFightMountTempcate.getTemplateById(selectTempId);
         var _loc3_:DragonTalkerFightMountTempInfo = model.battleBeastTempArr[model.battleBeastGrade - 1];
         var _loc2_:DragonTalkerFightMountTempInfo = model.battleBeastTempArr[model.battleBeastGrade];
         if(!_loc3_)
         {
            return;
         }
         if(_loc1_)
         {
            _mountAvatar.updateAvatarPath(_loc4_.AvatarPath);
         }
         _nameText.text = _loc4_.TemplateName;
         if(model.getIsFullByType(140,model.battleBeastGrade))
         {
            _expBar.full = true;
            _expBar.setText("Max");
            _trainBtn.enable = false;
            _addExpText.text = "";
         }
         else
         {
            _expBar.max = model.battleBesatCurMaxExp;
            _expBar.current = model.battleBeastExp;
            _trainBtn.enable = true;
            _addExpText.text = "+" + materialExp * int(_trainCountText.text);
         }
         hasMaterialCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(mountMaterialId);
         _beastCountText.text = hasMaterialCount + "";
         _curPropItem.showPropText(_loc3_);
         _nextPropItem.showPropText(_loc2_);
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_trainCountText);
         _trainCountText = null;
         ObjectUtils.disposeObject(_beastCountText);
         _beastCountText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_changeBtn);
         _changeBtn = null;
         ObjectUtils.disposeObject(_trainBtn);
         _trainBtn = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_curPropItem);
         _curPropItem = null;
         ObjectUtils.disposeObject(_nextPropItem);
         _nextPropItem = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         ObjectUtils.disposeObject(_addExpText);
         _addExpText = null;
         ObjectUtils.disposeObject(_mountAvatar);
         _mountAvatar = null;
         super.dispose();
      }
   }
}

