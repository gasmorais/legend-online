package map.campaign.view.ui.secretland
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaSecretInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.ConsortiaSkillHelper;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   
   public class ConsortiaSecretInfoView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _numTxt:FilterFrameText;
      
      private var _rateTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _expTxt:FilterFrameText;
      
      private var _expProgressImg:Bitmap;
      
      private var _expProgressMask:Shape;
      
      private var _helpBtn:BaseButton;
      
      private var _getTreeBtn:IconButton;
      
      private var _getBuffBtn:BaseButton;
      
      private var _data:ConsortiaSecretInfo;
      
      public function ConsortiaSecretInfoView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.campaign.SecretInfoBg");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.ConsortiaSecretInfoNumTxt");
         _rateTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.ConsortiaSecretInfoRateTxt");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.ConsortiaTreeGradeTxt");
         _expTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.ConsortiaTreeExpTxt");
         _expProgressImg = ComponentFactory.Instance.creatBitmap("asset.campaign.TreeExpProgressImg");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.ConsortiaSecretHelpBtn");
         _getBuffBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.ConsortiaSecretGetBuffBtn");
         _getTreeBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.ConsortiaSecretGetTreeBtn");
         _expProgressMask = new Shape();
         _expProgressMask.graphics.beginFill(16777215,0);
         _expProgressMask.graphics.drawRect(0,0,_expProgressImg.width,_expProgressImg.height);
         _expProgressMask.graphics.endFill();
         _expProgressMask.x = _expProgressImg.x;
         _expProgressMask.y = _expProgressImg.y;
         _expProgressImg.mask = _expProgressMask;
         _helpBtn.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.secretland.ConsortiaSecretInfoView.help");
         addChild(_bg);
         addChild(_numTxt);
         addChild(_rateTxt);
         addChild(_gradeTxt);
         addChild(_expProgressImg);
         addChild(_expProgressMask);
         addChild(_expTxt);
         addChild(_helpBtn);
      }
      
      private function addEvent() : void
      {
         _helpBtn.addEventListener("click",__onHelpClick);
         _getTreeBtn.addEventListener("click",__onGetTreeClick);
         _getBuffBtn.addEventListener("click",__onGetBuffClick);
         model.addEventListener("UPDA_CONSORTIA_CHAIRMAN",__chairmanChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _helpBtn.removeEventListener("click",__onHelpClick);
         _getTreeBtn.removeEventListener("click",__onGetTreeClick);
         _getBuffBtn.removeEventListener("click",__onGetBuffClick);
         model.removeEventListener("UPDA_CONSORTIA_CHAIRMAN",__chairmanChangeHandler);
      }
      
      private function __onHelpClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("campaign.ConsortiaSecretHelpFrame");
         _loc2_.show();
      }
      
      private function __onGetTreeClick(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("map.campaign.view.ui.secretland.ConsortiaSecretInfoView.callTree");
         SimpleAlertHelper.instance.data = [getTreeCall];
         SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc2_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true);
      }
      
      private function getTreeCall(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            ConsortiaSocketOutManager.sendCallSecretTree();
         }
      }
      
      private function __onGetBuffClick(param1:MouseEvent) : void
      {
         if(!showGetBuffAlert())
         {
            sendGetSecretBuff();
         }
      }
      
      private function showGetBuffAlert() : Boolean
      {
         var _loc7_:TodayNotAlertFrame = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:Date = SharedManager.instance.secretGetBuffTipCheckDate;
         var _loc4_:Date = new Date();
         var _loc1_:Boolean = false;
         var _loc5_:Boolean = Boolean(SharedManager.instance.secretGetBuffTip);
         if(!_loc5_ || _loc3_.month <= _loc3_.month && _loc3_.date < _loc4_.date)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("campaign.ConsortiaSecretGetBuffAlertFrame");
            _loc6_ = LanguageMgr.GetTranslation("map.campaign.view.ui.secretland.ConsortiaSecretInfoView.getBuff",ConsortiaModel.secretBuffPrice);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc7_.show(_loc6_,_loc2_,startGetBuffAlertBack);
         }
         return _loc1_;
      }
      
      private function startGetBuffAlertBack(param1:Boolean) : void
      {
         SharedManager.instance.secretGetBuffTip = param1;
         SharedManager.instance.secretGetBuffTipCheckDate = new Date();
         SharedManager.instance.saveSecretGetBuffTipCheck();
         sendGetSecretBuff();
      }
      
      private function sendGetSecretBuff() : void
      {
         if(playerInfo.consortiaOffer < ConsortiaModel.secretBuffPrice)
         {
            ConsortiaSkillHelper.addOffer();
            return;
         }
         ConsortiaSocketOutManager.sendGetSecretBuff();
      }
      
      private function __chairmanChangeHandler(param1:ConsortiaEvent) : void
      {
         refreshBtns();
      }
      
      public function setData(param1:ConsortiaSecretInfo) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(!_data)
         {
            clear();
            return;
         }
         _numTxt.text = _data.membersNum.toString();
         _rateTxt.text = _data.rate.toFixed(1);
         _gradeTxt.text = _data.treeGrade.toString();
         var _loc1_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_data.treeGrade + 1,20);
         if(_loc1_)
         {
            _expTxt.text = _data.treeGp + " / " + _loc1_.Data;
            _expProgressMask.width = _expProgressImg.width * _data.treeGp / _loc1_.Data;
         }
         else
         {
            _expTxt.text = LanguageMgr.GetTranslation("map.campaign.view.ui.secretland.ConsortiaTreeExpView.maxLevel");
            _expProgressMask.width = _expProgressImg.width;
         }
         refreshBtns();
      }
      
      private function refreshBtns() : void
      {
         if(!_data)
         {
            return;
         }
         if(_data.treeState == 2)
         {
            if(isChairman || Boolean(consortiaControl.getRightsByNum(45)))
            {
               addChild(_getTreeBtn);
            }
         }
         else if(_getTreeBtn.parent)
         {
            _getTreeBtn.parent.removeChild(_getTreeBtn);
         }
      }
      
      private function get consortiaControl() : ConsortiaControler
      {
         return FrameControllerManager.instance.consortiaController;
      }
      
      private function get isChairman() : Boolean
      {
         return model.consortiaInfo.chairmanID == thane.userId;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function clear() : void
      {
         _numTxt.text = "0";
         _rateTxt.text = "0";
         _gradeTxt.text = "1";
         _expTxt.text = "0 / 0";
         _expProgressMask.width = 1;
         if(_getTreeBtn.parent)
         {
            _getTreeBtn.parent.removeChild(_getTreeBtn);
         }
         if(_getBuffBtn.parent)
         {
            _getBuffBtn.parent.removeChild(_getBuffBtn);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_numTxt)
         {
            _numTxt.dispose();
         }
         _numTxt = null;
         if(_rateTxt)
         {
            _rateTxt.dispose();
         }
         _rateTxt = null;
         if(_gradeTxt)
         {
            _gradeTxt.dispose();
         }
         _gradeTxt = null;
         if(_expTxt)
         {
            _expTxt.dispose();
         }
         _expTxt = null;
         if(_helpBtn)
         {
            _helpBtn.dispose();
         }
         _helpBtn = null;
         if(_bg)
         {
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
            _bg.bitmapData.dispose();
         }
         if(_getTreeBtn)
         {
            _getTreeBtn.dispose();
         }
         _getTreeBtn = null;
         if(_getBuffBtn)
         {
            _getBuffBtn.dispose();
         }
         _getBuffBtn = null;
         _bg = null;
         if(_expProgressImg)
         {
            if(_expProgressImg.parent)
            {
               _expProgressImg.parent.removeChild(_expProgressImg);
            }
            _expProgressImg.bitmapData.dispose();
            _expProgressImg = null;
         }
         if(_expProgressMask)
         {
            if(_expProgressMask.parent)
            {
               _expProgressMask.parent.removeChild(_expProgressMask);
            }
            _expProgressMask.graphics.clear();
         }
         _expProgressMask = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

