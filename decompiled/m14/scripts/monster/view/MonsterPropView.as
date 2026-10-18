package monster.view
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import mainBar.vicePassword.VicePasswordUtil;
   import manager.LanguageMgr;
   import monster.cell.MonsterBagCell;
   import monster.item.MonsterShowAvatar;
   import monster.item.MonsterSkillIItem;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import yishi.GlobalConfig;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.MonsterTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.MonsterManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.ProgressCommon;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterPropView extends Component
   {
      
      private var _nameText:FilterFrameText;
      
      private var _addImage:Image;
      
      private var _propBack:MutipleImage;
      
      private var _pBack:MutipleImage;
      
      private var _enterWarBtn:IconButton;
      
      private var _firstBtn:IconButton;
      
      private var _restBtn:IconButton;
      
      private var _btnVpLock:BaseButton;
      
      private var _starHbox:HBox;
      
      private var _avatar:MonsterShowAvatar;
      
      private var _fightBmd:BitmapData;
      
      private var _fightCon:Component;
      
      private var _lvBmd:BitmapData;
      
      private var _lvCon:Component;
      
      private var _periodCon:Component;
      
      private var _expBar:ProgressCommon;
      
      private var _propBox:Component;
      
      private var _skillHbox:HBox;
      
      private var propLen:int = 8;
      
      private var data:MonsterInfo;
      
      private var tempInfo:MonsterTempInfo;
      
      private var preType:String;
      
      private var _bagView:MonsterPropBagView;
      
      private var _bagCell:MonsterBagCell;
      
      private var _accessoriesTxtBmp:Bitmap;
      
      private var _followBtn:BaseButton;
      
      private var _cancelFollowBtn:BaseButton;
      
      private var _isSelf:Boolean;
      
      public function MonsterPropView(param1:Boolean = true)
      {
         super();
         _isSelf = param1;
         initView();
         initOtherView();
         if(_isSelf)
         {
            addEvent();
            refreshView();
         }
      }
      
      private function initView() : void
      {
         _nameText = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterPropView.nameText");
         _addImage = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterPropView.addImage");
         _propBack = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterPropView.propBack");
         _pBack = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterPropView.pBack");
         _enterWarBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterPropView.enterWarBtn");
         _firstBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterPropView.firstBtn");
         _fightBmd = ComponentFactory.Instance.creatBitmapData("asset.MonsterPropView.fightRes");
         _fightCon = ComponentFactory.Instance.creatComponentByStylename("MonsterPropView.fightCon");
         _expBar = ComponentFactory.Instance.creatComponentByStylename("MonsterPropView.expBar");
         _propBox = ComponentFactory.Instance.creatComponentByStylename("MonsterPropView.propBox");
         _skillHbox = ComponentFactory.Instance.creatComponentByStylename("MonsterPropView.skillHbox");
         _lvBmd = ComponentFactory.Instance.creatBitmapData("asset.MonsterPropView.lvBmd");
         _lvCon = ComponentFactory.Instance.creatComponentByStylename("MonsterPropView.lvCon");
         _periodCon = ComponentFactory.Instance.creatComponentByStylename("MonsterPropView.periodCon");
         _starHbox = ComponentFactory.Instance.creatComponentByStylename("MonsterPropView.starHbox");
         _restBtn = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterPropView.restBtn");
         _btnVpLock = ComponentFactory.Instance.creatComponentByStylename("MonsterPropView.lockbtn");
         _followBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterPropView.followBtn");
         _cancelFollowBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterPropView.cancelFollowBtn");
         _bagCell = ComponentFactory.Instance.creatCustomObject("MonsterPropView.BagCell");
         _accessoriesTxtBmp = ComponentFactory.Instance.creatBitmap("asset.MonsterBagCell.accessoriesTxt");
         _avatar = new MonsterShowAvatar();
         addChild(_pBack);
         addChild(_propBack);
         addChild(_avatar);
         addChild(_nameText);
         addChild(_starHbox);
         addChild(_lvCon);
         addChild(_periodCon);
         addChild(_addImage);
         addChild(_fightCon);
         addChild(_expBar);
         addChild(_propBox);
         addChild(_skillHbox);
         addChild(_bagCell);
         if(_isSelf)
         {
            _bagView = ComponentFactory.Instance.creatCustomObject("MonsterPropView.bagView");
            addChild(_bagView);
            addChild(_btnVpLock);
            addChild(_firstBtn);
            addChild(_enterWarBtn);
            addChild(_restBtn);
            addChild(_accessoriesTxtBmp);
         }
         if(VersionSwitch.MONSTER_FOLLOW && _isSelf)
         {
            addChild(_followBtn);
            addChild(_cancelFollowBtn);
         }
         _avatar.x = 165;
         _avatar.y = 305;
         this.mouseEnabled = false;
         _btnVpLock.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.vicepasswordBtnTipData");
      }
      
      public function changeOtherData(param1:MonsterInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_bagCell)
         {
            _bagCell.visible = false;
         }
         data = param1;
         refreshView();
      }
      
      private function initOtherView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ProgressCommon = null;
         var _loc3_:int = 0;
         var _loc4_:MonsterSkillIItem = null;
         _loc2_ = 0;
         while(_loc2_ < propLen)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("MonsterPropView.propItem");
            _loc1_.y = _loc2_ * 29;
            _propBox.addChild(_loc1_);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc4_ = new MonsterSkillIItem(1,_loc3_);
            _skillHbox.addChild(_loc4_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         _firstBtn.addEventListener("click",_firstBtnClickHandler);
         _enterWarBtn.addEventListener("click",_enterWarBtnClickHandler);
         if(_restBtn)
         {
            _restBtn.addEventListener("click",_restBtnClickHandler);
         }
         if(_followBtn)
         {
            _followBtn.addEventListener("click",__followBtnHandler);
         }
         if(_cancelFollowBtn)
         {
            _cancelFollowBtn.addEventListener("click",__cancelFollowBtnHandler);
         }
         _btnVpLock.addEventListener("click",__vpLockHandler);
         MsgMan.addObserver("MONSTER_INFO_CHANGE",this,__updateMonsterListHandler);
         MsgMan.addObserver("MONSTER_ITEM_SELECT",this,__updateSelectHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function removeEvent() : void
      {
         if(_firstBtn)
         {
            _firstBtn.removeEventListener("click",_firstBtnClickHandler);
         }
         if(_enterWarBtn)
         {
            _enterWarBtn.removeEventListener("click",_enterWarBtnClickHandler);
         }
         if(_restBtn)
         {
            _restBtn.removeEventListener("click",_restBtnClickHandler);
         }
         if(_btnVpLock)
         {
            _btnVpLock.removeEventListener("click",__vpLockHandler);
         }
         if(_followBtn)
         {
            _followBtn.removeEventListener("click",__followBtnHandler);
         }
         if(_cancelFollowBtn)
         {
            _cancelFollowBtn.removeEventListener("click",__cancelFollowBtnHandler);
         }
         MsgMan.removeObserver("MONSTER_INFO_CHANGE",this,__updateMonsterListHandler);
         MsgMan.removeObserver("MONSTER_ITEM_SELECT",this,__updateSelectHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function __vpLockHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         if(playerInfo.isDuringResetTime)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("vicepassword.description1"));
            return;
         }
         if(playerInfo.hasVicePassword == 0)
         {
            FrameControllerManager.instance.openControllerByInfo("vicepassword",1);
         }
         else
         {
            SoundManager.instance.play("022");
            param1.stopPropagation();
            param1.stopImmediatePropagation();
            if(GlobalConfig.isConfirmPassword)
            {
               VicePasswordUtil.vpLockOp(6,0,data.monsterId);
            }
            else
            {
               FrameControllerManager.instance.openControllerByInfo("vicepassword",3);
            }
         }
      }
      
      private function __followBtnHandler(param1:MouseEvent) : void
      {
         if(data)
         {
            MonsterManager.instance.sendMonsterOperate(19,data.monsterId);
         }
      }
      
      private function __cancelFollowBtnHandler(param1:MouseEvent) : void
      {
         if(data)
         {
            MonsterManager.instance.sendMonsterOperate(20,data.monsterId);
         }
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.bagType == 36)
         {
            return;
         }
         setBagCellData();
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.bagType == 36)
         {
            return;
         }
         setBagCellData();
      }
      
      private function setBagCellData() : void
      {
         if(!data)
         {
            _bagCell.data = null;
            return;
         }
         var _loc1_:GoodsInfo = GoodsManager.instance.getMonsterBagGoodsInfo(data.monsterId);
         _bagCell.data = _loc1_;
      }
      
      private function __updateSelectHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __updateMonsterListHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function _firstBtnClickHandler(param1:MouseEvent) : void
      {
         MonsterManager.instance.sendMonsterOperate(18,data.monsterId);
      }
      
      private function _restBtnClickHandler(param1:MouseEvent) : void
      {
         MonsterManager.instance.sendMonsterOperate(17,data.monsterId);
      }
      
      private function _enterWarBtnClickHandler(param1:MouseEvent) : void
      {
         MonsterManager.instance.sendMonsterOperate(17,data.monsterId);
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:ProgressCommon = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:MonsterSkillIItem = null;
         if(_isSelf)
         {
            data = model.selectMonster;
         }
         if(!data || !data.tempInfo)
         {
            return;
         }
         refreshTempChange();
         NumberViewUtils.refreshValue(data.fightPower,_fightCon,_fightBmd,21,29,16,21,"0123456789");
         NumberViewUtils.refreshValue(data.grade,_lvCon,_lvBmd,18,22,14,18,"0123456789");
         NumberViewUtils.refreshValue(data.stageGrade,_periodCon,_lvBmd,18,22,14,18,"0123456789");
         _firstBtn.enable = model.showMonsterList[0] != data;
         _enterWarBtn.visible = !data.enterWar;
         _restBtn.visible = data.enterWar;
         var _loc6_:int = int(model.getNextGradeExp(data));
         if(data.grade >= data.tempInfo.MaxLevel)
         {
            _expBar.value = 1;
            _expBar.text = LanguageMgr.GetTranslation("card.CardBagCell.expMax");
         }
         else
         {
            _expBar.value = data.curExp / _loc6_;
            _expBar.text = data.curExp + "/" + _loc6_;
         }
         var _loc3_:MonsterInfo = model.getMaxMonsterInfo(data);
         _loc4_ = 0;
         while(_loc4_ < propLen)
         {
            _loc1_ = _propBox.getChildAt(_loc4_) as ProgressCommon;
            _loc5_ = int(model.getPropValueByIndex(_loc4_,data));
            _loc2_ = int(model.getPropValueByIndex(_loc4_,_loc3_));
            _loc1_.value = _loc5_ / _loc2_;
            _loc1_.text = _loc5_ + "/" + _loc2_;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc7_ = _skillHbox.getChildAt(_loc4_) as MonsterSkillIItem;
            _loc7_.data = data.activeSkillAry.length > _loc4_ ? data.activeSkillAry[_loc4_] : null;
            _loc4_++;
         }
         var _loc8_:int = int(data.typeIndex);
         _loc8_ = int(_loc8_ > 0 ? _loc8_ : 1);
         _bagCell.back.setFrame(_loc8_);
         if(data.isFollow)
         {
            _cancelFollowBtn.visible = true;
            _followBtn.visible = false;
         }
         else
         {
            _cancelFollowBtn.visible = false;
            _followBtn.visible = true;
         }
         setBagCellData();
      }
      
      private function refreshTempChange() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Bitmap = null;
         if(preType != data.type + "_" + data.star)
         {
            _avatar.data = data.tempInfo;
            _nameText.text = data.name;
            _starHbox.removeAllChild();
            _loc2_ = 0;
            while(_loc2_ < data.star)
            {
               _loc1_ = ComponentFactory.Instance.creatBitmap("asset.MonsterPropView.starBitmap");
               _starHbox.addChild(_loc1_);
               _loc2_++;
            }
         }
         preType = data.type + "_" + data.star;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get bagView() : MonsterPropBagView
      {
         return _bagView;
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_addImage);
         _addImage = null;
         ObjectUtils.disposeObject(_propBack);
         _propBack = null;
         ObjectUtils.disposeObject(_pBack);
         _pBack = null;
         ObjectUtils.disposeObject(_enterWarBtn);
         _enterWarBtn = null;
         ObjectUtils.disposeObject(_firstBtn);
         _firstBtn = null;
         ObjectUtils.disposeObject(_fightBmd);
         _fightBmd = null;
         ObjectUtils.disposeObject(_fightCon);
         _fightCon = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         ObjectUtils.disposeObject(_propBox);
         _propBox = null;
         ObjectUtils.disposeObject(_lvBmd);
         _lvBmd = null;
         ObjectUtils.disposeObject(_lvCon);
         _lvCon = null;
         ObjectUtils.disposeObject(_periodCon);
         _periodCon = null;
         ObjectUtils.disposeObject(_avatar);
         _avatar = null;
         ObjectUtils.disposeObject(_restBtn);
         _restBtn = null;
         ObjectUtils.disposeObject(_btnVpLock);
         _btnVpLock = null;
         ObjectUtils.disposeObject(_starHbox);
         _starHbox = null;
         ObjectUtils.disposeObject(_skillHbox);
         _skillHbox = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         ObjectUtils.disposeObject(_bagCell);
         _bagCell = null;
         ObjectUtils.disposeObject(_accessoriesTxtBmp);
         _accessoriesTxtBmp = null;
         ObjectUtils.disposeObject(_followBtn);
         _followBtn = null;
         ObjectUtils.disposeObject(_cancelFollowBtn);
         _cancelFollowBtn = null;
         super.dispose();
      }
   }
}

