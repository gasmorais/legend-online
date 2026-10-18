package armyII.viewII.pawnupgrade
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.army.ComprehendMsg;
   import events.PawnEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.armyII.ArmyPawn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.PawnSpecialTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.community.BulePowerItem;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PawnSpecialAbilityFrame extends Frame
   {
      
      private var _back:Bitmap;
      
      private var _old:Bitmap;
      
      private var _new:Bitmap;
      
      private var _costSoul:Bitmap;
      
      private var _ownSoul:Bitmap;
      
      private var _bless:Bitmap;
      
      private var _costValue:FilterFrameText;
      
      private var _ownValue:FilterFrameText;
      
      private var _insteadBtn:TextButton;
      
      private var _apperceiveBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      private var _blessExp:BulePowerItem;
      
      private var _oldItem:PawnSpecialItem;
      
      private var _newItem:PawnSpecialItem;
      
      private var _pawn:ArmyPawn;
      
      public function PawnSpecialAbilityFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.armyII.PawnSpecialFrameBack");
         _old = ComponentFactory.Instance.creatBitmap("asset.armyII.PawnSpecialFrameOldAsset");
         _new = ComponentFactory.Instance.creatBitmap("asset.armyII.PawnSpecialFrameNewAsset");
         _bless = ComponentFactory.Instance.creatBitmap("asset.armyII.PawnSpecialFrameBlessAsset");
         _costSoul = ComponentFactory.Instance.creatBitmap("asset.armyII.PawnSpecialFrameCostAsset");
         _ownSoul = ComponentFactory.Instance.creatBitmap("asset.armyII.PawnSpecialFrameOwnAsset");
         _costValue = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnSpecialFrameCostValue");
         _ownValue = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnSpecialFrameOwnValue");
         _insteadBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnSpecialInsteadBtn");
         _apperceiveBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnSpecialApperceiveBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnSpecialHelpBtn");
         _oldItem = ComponentFactory.Instance.creatCustomObject("armyII.PawnSpecialOldItem");
         _newItem = ComponentFactory.Instance.creatCustomObject("armyII.PawnSpecialNewItem");
         _blessExp = ComponentFactory.Instance.creatCustomObject("armyII.PawnSpecialBlessExp");
         addToContent(_back);
         addToContent(_old);
         addToContent(_new);
         addToContent(_bless);
         addToContent(_costSoul);
         addToContent(_ownSoul);
         addToContent(_costValue);
         addToContent(_ownValue);
         addToContent(_insteadBtn);
         addToContent(_apperceiveBtn);
         addToContent(_helpBtn);
         addToContent(_oldItem);
         addToContent(_newItem);
         addToContent(_blessExp);
         _insteadBtn.text = LanguageMgr.GetTranslation("buildings.casern.view.PawnSpecialAbilityFrame.instead");
         titleText = LanguageMgr.GetTranslation("buildings.casern.view.PawnSpecialAbilityFrame.Title");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _helpBtn.addEventListener("click",__helpHandler);
         _insteadBtn.addEventListener("click",__insteadHandler);
         _apperceiveBtn.addEventListener("click",__apperceiveHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
         _insteadBtn.removeEventListener("click",__insteadHandler);
         _apperceiveBtn.removeEventListener("click",__apperceiveHandler);
         if(_pawn)
         {
            _pawn.removeEventListener("SPECIAL_BLESS",__blessChangeHandler);
            _pawn.removeEventListener("SPECIAL_ALIBITY",__changeChangeHandler);
         }
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("armyII.pawnSpecialHelpFrame");
         _loc2_.show();
      }
      
      private function __insteadHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("armyII.viewII.pawnupgrade.PawnSpecialAbilityFrame.sureFrameDescribe");
         SimpleAlertHelper.instance.data = [__insteadSend];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
      }
      
      private function __insteadSend(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:PackageOut = null;
         var _loc3_:ComprehendMsg = null;
         if(param1)
         {
            _loc4_ = new PackageOut(8456);
            _loc3_ = new ComprehendMsg();
            _loc3_.templateId = _pawn.templateId;
            SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
         }
      }
      
      private function __apperceiveHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc6_:PawnSpecialTempInfo = TempleteManager.instance.pawnSpecialTemplateCate.getTemplateByID(int(_pawn.tempSpecial));
         var _loc4_:PawnSpecialTempInfo = TempleteManager.instance.pawnSpecialTemplateCate.getTemplateByID(int(_pawn.specialAbility));
         if(_loc6_ && _loc4_ && _loc6_.Grades > _loc4_.Grades)
         {
            _loc2_ = LanguageMgr.GetTranslation("buildings.casern.view.PawnSpecialAbilityFrame.BetterAlert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc5_:PackageOut = new PackageOut(8455);
         var _loc3_:ComprehendMsg = new ComprehendMsg();
         _loc3_.templateId = _pawn.templateId;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc3_);
      }
      
      private function __changeChangeHandler(param1:PawnEvent) : void
      {
         refreshView();
      }
      
      private function __blessChangeHandler(param1:PawnEvent) : void
      {
         refreshBless();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      private function refreshBless() : void
      {
         var _loc2_:PawnSpecialTempInfo = null;
         var _loc1_:UpgradeTemplateInfo = null;
         if(_pawn)
         {
            _blessExp.current = _pawn.blessNum;
            _loc2_ = TempleteManager.instance.pawnSpecialTemplateCate.getTemplateByID(int(_pawn.specialAbility));
            if(_loc2_)
            {
               _loc1_ = TempleteManager.instance.getTemplateByLevelAndType(_loc2_.Grades,16);
               _blessExp.max = _loc1_.Data;
            }
            else
            {
               _blessExp.max = 0;
            }
         }
      }
      
      private function refreshView() : void
      {
         var _loc2_:PawnSpecialTempInfo = null;
         var _loc1_:PawnSpecialTempInfo = null;
         if(_pawn)
         {
            _loc2_ = TempleteManager.instance.pawnSpecialTemplateCate.getTemplateByID(int(_pawn.tempSpecial));
            _loc1_ = TempleteManager.instance.pawnSpecialTemplateCate.getTemplateByID(int(_pawn.specialAbility));
            _costValue.text = "1000000";
            _ownValue.text = playerInfo.strategy.toString();
            _oldItem.data = _loc1_;
            _newItem.data = _loc2_;
            _pawn.addEventListener("SPECIAL_ALIBITY",__changeChangeHandler);
            _pawn.addEventListener("SPECIAL_BLESS",__blessChangeHandler);
            _insteadBtn.enable = !StringHelper.isNullOrEmpty(_pawn.tempSpecial);
            refreshBless();
            if(_loc1_.Grades >= 10)
            {
               _blessExp.visible = false;
               _bless.visible = false;
            }
            else
            {
               _blessExp.visible = true;
               _bless.visible = true;
            }
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show(param1:ArmyPawn) : void
      {
         _pawn = param1;
         refreshView();
         refreshBless();
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_old);
         _old = null;
         ObjectUtils.disposeObject(_new);
         _new = null;
         ObjectUtils.disposeObject(_costSoul);
         _costSoul = null;
         ObjectUtils.disposeObject(_ownSoul);
         _ownSoul = null;
         ObjectUtils.disposeObject(_costValue);
         _costValue = null;
         ObjectUtils.disposeObject(_ownValue);
         _ownValue = null;
         ObjectUtils.disposeObject(_insteadBtn);
         _insteadBtn = null;
         ObjectUtils.disposeObject(_apperceiveBtn);
         _apperceiveBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_oldItem);
         _apperceiveBtn = null;
         ObjectUtils.disposeObject(_newItem);
         _helpBtn = null;
         super.dispose();
      }
   }
}

