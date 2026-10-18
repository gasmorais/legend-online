package dragontitan
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTitanManager;
   import mvc.module.dragonTitan.DragonTitanModel;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.component.TileContainer;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTitanArrangeView extends Component
   {
      
      private static const SKILL_COUNT:int = 10;
      
      private static const ARROW_COUNT:int = 8;
      
      private var _fightSkillImgTxt:Image;
      
      private var _skillSelectCombox:ComboBox;
      
      private var _skillContiner:TileContainer;
      
      private var _skillSlots:Vector.<DragonTitanSkillSlot>;
      
      private var _arrowContiner:TileContainer;
      
      private var _stateBtn:IconButton;
      
      private var _materialImage:Bitmap;
      
      private var _hasCountText:FilterFrameText;
      
      private var _desc:FilterFrameText;
      
      private var comboxIndex:int;
      
      private var btnState:int;
      
      private var openPageCost:int;
      
      private var openSkillConfigArr:Array;
      
      public function DragonTitanArrangeView()
      {
         super();
         openPageCost = ConfigInfoManager.instance.getTitanSkillGroupCost();
         openSkillConfigArr = ConfigInfoManager.instance.getTitanSkillItemCost();
         initView();
         initSkillView();
         initComBoxData();
         initEvent();
         refreshView(null,null);
      }
      
      private function initView() : void
      {
         _fightSkillImgTxt = ComponentFactory.Instance.creatComponentByStylename("dragontitan.fightSkillImgTxt");
         _skillSelectCombox = ComponentFactory.Instance.creatComponentByStylename("dragontitan.skillSelectCombox");
         _desc = ComponentFactory.Instance.creatComponentByStylename("DragonTitanArrangeView.desc");
         _skillContiner = ComponentFactory.Instance.creatCustomObject("DragonTitanArrangeView.skillContiner");
         _arrowContiner = ComponentFactory.Instance.creatCustomObject("DragonTitanArrangeView.arrowContiner");
         _stateBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTitanArrangeView.stateBtn");
         _materialImage = ComponentFactory.Instance.creatBitmap("asset.DragonTitanArrangeView.materialImage");
         _hasCountText = ComponentFactory.Instance.creatComponentByStylename("DragonTitanArrangeView.hasCountText");
         addChild(_skillSelectCombox);
         addChild(_fightSkillImgTxt);
         addChild(_skillContiner);
         addChild(_arrowContiner);
         addChild(_stateBtn);
         addChild(_materialImage);
         addChild(_hasCountText);
         addChild(_desc);
         _arrowContiner.mouseChildren = _arrowContiner.mouseEnabled = false;
         _desc.text = LanguageMgr.GetTranslation("DragonTitanArrangeView.desc");
      }
      
      private function initSkillView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:DragonTitanSkillSlot = null;
         var _loc1_:Image = null;
         _skillSlots = new Vector.<DragonTitanSkillSlot>();
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc2_ = new DragonTitanSkillSlot(_loc3_);
            _skillContiner.appendItem(_loc2_);
            _skillSlots.push(_loc2_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("dragontitan.skillArrow");
            _arrowContiner.appendItem(_loc1_);
            _loc3_++;
         }
      }
      
      private function initComBoxData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = LanguageMgr.GetTranslation("dragontitan.skillSelectCombox.itemText" + _loc1_);
            _skillSelectCombox.listPanel.vectorListModel.append(_loc2_);
            _loc1_++;
         }
         comboxIndex = model.curUseSkillIndex;
         model.comboxIndex = comboxIndex;
         _skillSelectCombox.listPanel.list.defaultSelectItemByCellValue = LanguageMgr.GetTranslation("dragontitan.skillSelectCombox.itemText" + comboxIndex);
      }
      
      private function initEvent() : void
      {
         MsgMan.addObserver("DragonTitanEvent.TITAN_SET_SKILL",this,setSkillHandle);
         MsgMan.addObserver("DragonTitanEvent.TITAN_DATA",this,refreshView);
         _skillSelectCombox.listPanel.list.addEventListener("listItemClick",__onSelectItemHandler);
         _stateBtn.addEventListener("click",__stateBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("DragonTitanEvent.TITAN_SET_SKILL",this,setSkillHandle);
         MsgMan.removeObserver("DragonTitanEvent.TITAN_DATA",this,refreshView);
         if(_skillSelectCombox)
         {
            _skillSelectCombox.listPanel.list.removeEventListener("listItemClick",__onSelectItemHandler);
         }
         if(_stateBtn)
         {
            _stateBtn.removeEventListener("click",__stateBtnClickHandler);
         }
      }
      
      private function __onSelectItemHandler(param1:ListItemEvent) : void
      {
         comboxIndex = param1.index;
         model.comboxIndex = comboxIndex;
         refreshView(null,null);
      }
      
      private function __stateBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(btnState == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTitanArrangeView.curSkill.usingAlert"));
            return;
         }
         if(btnState == 2)
         {
            DragonTitanManager.instance.sendSelectSkillGroup(comboxIndex);
         }
         else if(btnState == 3)
         {
            SimpleAlertHelper.instance.data = [__openSkillGroupHandler];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("DragonTitanArrangeView.openSkill.costAlert",openPageCost);
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2);
         }
      }
      
      private function __openSkillGroupHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(param1)
         {
            _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            if(_loc3_ < openPageCost)
            {
               RechargeAlertMannager.show();
               return;
            }
            DragonTitanManager.instance.sendOpenSkillGroup(comboxIndex);
         }
      }
      
      private function refreshView(param1:String = null, param2:Object = null) : void
      {
         var _loc4_:int = 0;
         var _loc3_:DragonTitanSkillSlot = null;
         _hasCountText.text = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(openSkillConfigArr[0]) + "";
         resetBtnState();
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _loc3_ = _skillSlots[_loc4_];
            if(_loc4_ < curSelectSkillArr.length)
            {
               _loc3_.data = model.getSkillTempInfoByTitanId(curSelectSkillArr[_loc4_]);
               _loc3_.isLock = curSelectSkillArr[_loc4_] == -1;
            }
            else
            {
               _loc3_.data = null;
               _loc3_.isLock = true;
            }
            _loc4_++;
         }
      }
      
      private function resetBtnState() : void
      {
         var _loc1_:Boolean = false;
         if(comboxIndex == model.curUseSkillIndex)
         {
            btnState = 1;
            _stateBtn.backStyle = "asset.DragonTitanArrangeView.stateBtnBack1";
            _stateBtn.iconStyle = "asset.DragonTitanArrangeView.stateBtnTxt1";
            _stateBtn.iconInnerRectString = "20,76,8,32,13";
         }
         else
         {
            _stateBtn.backStyle = "asset.DragonTitanArrangeView.stateBtnBack2";
            _loc1_ = Boolean(model.getIsSkillGroupActive(curSelectSkillArr));
            if(_loc1_)
            {
               btnState = 2;
               _stateBtn.iconStyle = "asset.DragonTitanArrangeView.stateBtnTxt2";
               _stateBtn.iconInnerRectString = "28,62,8,32,13";
            }
            else
            {
               btnState = 3;
               _stateBtn.iconStyle = "asset.DragonTitanArrangeView.stateBtnTxt3";
               _stateBtn.iconInnerRectString = "28,62,8,32,13";
            }
         }
      }
      
      private function setSkillHandle(param1:String = null, param2:Object = null) : void
      {
         var _loc6_:int = 0;
         var _loc3_:DragonTitanSkillSlot = null;
         var _loc4_:int = int(param2.titanId);
         var _loc5_:int = int(param2.index);
         if(curSelectSkillArr[_loc5_] == _loc4_ || _skillSlots[_loc5_].isLock)
         {
            return;
         }
         if(_loc5_ > -1 && _loc5_ < 10)
         {
            if(_loc4_ > 0)
            {
               _loc6_ = 0;
               while(_loc6_ < 10)
               {
                  _loc3_ = _skillSlots[_loc6_];
                  if(curSelectSkillArr[_loc6_] == _loc4_)
                  {
                     curSelectSkillArr[_loc6_] = curSelectSkillArr[_loc5_];
                     _loc3_.data = model.getSkillTempInfoByTitanId(curSelectSkillArr[_loc6_]);
                  }
                  _loc6_++;
               }
            }
            curSelectSkillArr[_loc5_] = _loc4_;
            _skillSlots[_loc5_].data = model.getSkillTempInfoByTitanId(_loc4_);
            MsgMan.notifyObserver("DragonTitanEvent.TITAN_SET_SKILL_BACK");
            DragonTitanManager.instance.sendSkills(comboxIndex,curSelectSkillArr.join(","));
         }
      }
      
      private function get curSelectSkillArr() : Array
      {
         return model.skillGroupArr[comboxIndex];
      }
      
      private function get model() : DragonTitanModel
      {
         return DragonTitanManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_skillSelectCombox)
         {
            ObjectUtils.disposeObject(_skillSelectCombox);
         }
         _skillSelectCombox = null;
         if(_fightSkillImgTxt)
         {
            ObjectUtils.disposeObject(_fightSkillImgTxt);
         }
         _fightSkillImgTxt = null;
         if(_skillContiner)
         {
            ObjectUtils.disposeObject(_skillContiner);
         }
         _skillContiner = null;
         if(_arrowContiner)
         {
            ObjectUtils.disposeObject(_arrowContiner);
         }
         _arrowContiner = null;
         if(_stateBtn)
         {
            ObjectUtils.disposeObject(_arrowContiner);
         }
         _arrowContiner = null;
         if(_materialImage)
         {
            ObjectUtils.disposeObject(_materialImage);
         }
         _materialImage = null;
         if(_hasCountText)
         {
            ObjectUtils.disposeObject(_hasCountText);
         }
         _hasCountText = null;
         if(_desc)
         {
            ObjectUtils.disposeObject(_desc);
         }
         _desc = null;
         LogicUtils.disposeDisplayCollection(_skillSlots);
         _skillSlots = null;
         super.dispose();
      }
   }
}

