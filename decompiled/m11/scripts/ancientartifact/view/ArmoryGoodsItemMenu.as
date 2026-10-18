package ancientartifact.view
{
   import ancientartifact.view.item.AncientBagCell;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.MopupManager;
   import managers.MountsManager;
   import managers.OfferRewardManager;
   import map.campaign.CampaignManager;
   import mvc.module.buildings.OfferRewardModel;
   import mvc.module.fashion.FashionModel;
   import mvc.module.pet.PetData;
   import simplegame.christmasroses.SnowRosePresentView;
   import simplegame.roses.RosePresentView;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.CrossBugleFrame;
   import yishi.view.community.RenameView;
   import yishi.view.tips.MessageTipManager;
   
   public class ArmoryGoodsItemMenu extends Sprite implements Disposeable
   {
      
      private var _currentItem:AncientBagCell;
      
      private var _back:ScaleBitmapImage;
      
      private var _useBtn:TextButton;
      
      private var _vBox:VBox;
      
      private var _showMuti:Boolean;
      
      public function ArmoryGoodsItemMenu(param1:AncientBagCell, param2:Boolean = true)
      {
         super();
         _currentItem = param1;
         _showMuti = param2;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _useBtn = ComponentFactory.Instance.creatComponentByStylename("core.UseButton");
         _useBtn.text = LanguageMgr.GetTranslation("cell.view.ArmoryGoodsItemMenu.delete");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("core.GoodsItemMenuContain");
         _vBox.addChild(_useBtn);
         addChild(_vBox);
      }
      
      private function initEvent() : void
      {
         _useBtn.addEventListener("click",__userHandler);
      }
      
      private function removeEvent() : void
      {
         if(_useBtn)
         {
            _useBtn.removeEventListener("click",__userHandler);
         }
      }
      
      private function __userHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(_currentItem && _currentItem.data)
         {
            SimpleAlertHelper.instance.data = [__mountCardUserHandler,_currentItem.data];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
         }
         dispose();
      }
      
      private function __mountCardUserHandler(param1:Boolean, param2:Boolean, param3:GoodsInfo) : void
      {
         if(param1)
         {
            MountsManager.instance.sendUseGoods(param3,false);
         }
      }
      
      private function useGroupfbIncomeAlert(param1:GoodsInfo) : void
      {
         SimpleAlertHelper.instance.data = [useGroupfbIncomeBack,param1];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc2_:String = LanguageMgr.GetTranslation("PlayerBagCellClickMediator.useGroupfbIncome.Tips",param1.templateInfo.Property3);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_);
      }
      
      private function useGroupfbIncomeBack(param1:Boolean, param2:Boolean, param3:GoodsInfo) : void
      {
         var _loc4_:String = null;
         if(param1)
         {
            if(thane.vocationGrades <= 0)
            {
               _loc4_ = LanguageMgr.GetTranslation("fund.fundRewardView.NewbieTip");
               MessageTipManager.instance().show(_loc4_);
               return;
            }
            if(playerInfo.weary < param3.templateInfo.Property3)
            {
               _loc4_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData03");
               MessageTipManager.instance().show(_loc4_);
               return;
            }
            SocketSendManager.instance.sendUseItem(param3.pos);
         }
      }
      
      private function checkForUseBox(param1:GoodsInfo, param2:int) : void
      {
         SimpleAlertHelper.instance.data = [useBoxCallBack,param1,param2];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateInfo.Property2).TemplateName;
         var _loc7_:String = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command09",1,param1.templateInfo.TemplateName,1 * param1.templateInfo.Property3,_loc5_);
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc3_,_loc4_,true,true,true);
      }
      
      private function useBoxCallBack(param1:Boolean, param2:Boolean, param3:GoodsInfo, param4:int) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendUseItem(param3.pos,param4);
         }
      }
      
      private function checkForUsePetExpBook(param1:GoodsInfo) : void
      {
         SimpleAlertHelper.instance.data = [checkForUsePetExpBookBack,param1];
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("checkForUsePetExpBook.content02",param1.templateInfo.Property2);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc3_,_loc4_,_loc2_,true,true,true);
      }
      
      private function checkForUsePetExpBookBack(param1:Boolean, param2:Boolean, param3:GoodsInfo) : void
      {
         var _loc4_:String = null;
         if(!param1)
         {
            return;
         }
         if(!param3)
         {
            return;
         }
         var _loc5_:PetData = playerInfo.enterWarPet;
         if(!_loc5_)
         {
            _loc4_ = LanguageMgr.GetTranslation("checkForUsePetExpBook.content01");
            MessageTipManager.instance().show(_loc4_);
            return;
         }
         if(_loc5_.isFullExp())
         {
            _loc4_ = LanguageMgr.GetTranslation("PetSwallowView.fullExp");
            MessageTipManager.instance().show(_loc4_);
            return;
         }
         SocketSendManager.instance.sendUseItem(param3.pos);
      }
      
      private function checkForUsePetLandTransfer(param1:GoodsInfo) : void
      {
         var _loc5_:String = null;
         var _loc3_:String = null;
         var _loc7_:String = null;
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc6_:Boolean = false;
         switch(SceneManager.instance.currentType)
         {
            case "SPACE_SCENE":
            case "CASTLE_SCENE":
            case "FARM":
               _loc6_ = true;
               break;
            case "CAMPAIGN_MAP_SCENE":
               if(CampaignManager.instance.mapModel)
               {
                  if(WorldBossHelper.checkPetLand(CampaignManager.instance.mapId))
                  {
                     _loc6_ = true;
                  }
               }
               break;
            default:
               _loc6_ = false;
         }
         if(_loc6_)
         {
            SimpleAlertHelper.instance.data = [checkForUsePetLandTransferBack,param1];
            _loc5_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("public.prompt");
            _loc4_ = LanguageMgr.GetTranslation("checkForUsePetLandTransfer.content01",getPetLandLevel(param1.templateInfo.Property1));
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc4_,_loc5_,_loc3_,true,true,true);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("checkForUsePetLandTransfer.content02");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function checkForUsePetLandTransferBack(param1:Boolean, param2:Boolean, param3:GoodsInfo) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(!param1)
         {
            return;
         }
         if(!param3)
         {
            return;
         }
         if(MopupManager.instance.model.isMopup)
         {
            _loc4_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc4_);
            return;
         }
         if(FreedomTeamManager.instance.model != null && Boolean(FreedomTeamManager.instance.model.followFlag))
         {
            FreedomTeamManager.instance.model.followFlag = false;
            _loc5_ = LanguageMgr.GetTranslation("map.internals.mediator.team.FreedomTeamFollowMediator.Tips02");
            MessageTipManager.instance().show(_loc5_);
         }
         PlayerManager.instance.currentPlayerModel.inCastle = false;
         SocketSendManager.instance.sendUseItem(param3.pos);
      }
      
      private function getPetLandLevel(param1:int) : String
      {
         var _loc2_:String = LanguageMgr.GetTranslation("checkForUsePetLandTransfer.level01");
         switch(param1 - 20001)
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("checkForUsePetLandTransfer.level01");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("checkForUsePetLandTransfer.level02");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("checkForUsePetLandTransfer.level03");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("checkForUsePetLandTransfer.level04");
         }
         return _loc2_;
      }
      
      private function checkWearyCanGet(param1:int, param2:int, param3:int = 1) : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc6_:int = 200 - playerInfo.weary;
         if(param1 > _loc6_)
         {
            SimpleAlertHelper.instance.data = [wearyCanGetCallBack,param1,param2,param3];
            _loc4_ = LanguageMgr.GetTranslation("public.confirm");
            _loc5_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("map.campaign.view.frame.SubmitResourcesFrame.titleTextTip");
            _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command07",_loc6_);
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc4_,_loc5_,true,true,true);
            return false;
         }
         return true;
      }
      
      private function checkWearyTodayCanGet(param1:int, param2:int, param3:int = 1) : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc6_:int = 600 - playerInfo.wearyLimit;
         if(param1 > _loc6_)
         {
            SimpleAlertHelper.instance.data = [wearyTodayCanGetCallBack,param1,param2,param3,true];
            _loc4_ = LanguageMgr.GetTranslation("public.confirm");
            _loc5_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("map.campaign.view.frame.SubmitResourcesFrame.titleTextTip");
            _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command06",600,_loc6_);
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc4_,_loc5_,true,true,true);
            return false;
         }
         return true;
      }
      
      private function wearyCanGetCallBack(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:int = 1) : void
      {
         if(param1)
         {
            if(checkWearyTodayCanGet(param3,param4,param5))
            {
               SocketSendManager.instance.sendUseItem(param4,param5);
            }
         }
      }
      
      private function wearyTodayCanGetCallBack(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:int = 1, param6:Boolean = false) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendUseItem(param4,param5);
         }
      }
      
      private function openRosePresentCall(param1:Array) : void
      {
         var _loc2_:RosePresentView = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentView");
         _loc2_.setData(param1[0]);
         _loc2_.show();
      }
      
      private function openCrossBugleCall(param1:Array) : void
      {
         var _loc2_:CrossBugleFrame = ComponentFactory.Instance.creatComponentByStylename("core.CrossBugleFrame");
         _loc2_.setData(param1[0]);
         _loc2_.show();
      }
      
      private function openRenameCall(param1:Array) : void
      {
         var _loc2_:RenameView = new RenameView(1,null,param1[0]);
         _loc2_.show();
      }
      
      private function callBack(param1:Boolean, param2:int) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendUseItem(param2);
         }
      }
      
      private function openSnowRosePresentCall(param1:Array) : void
      {
         var _loc2_:SnowRosePresentView = ComponentFactory.Instance.creatComponentByStylename("friends.SnowRosePresentView");
         _loc2_.setData(param1[0]);
         _loc2_.show();
      }
      
      private function get rewardModel() : OfferRewardModel
      {
         return OfferRewardManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      public function dispose() : void
      {
         _currentItem = null;
         removeEvent();
         StageReferance.stage.focus = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_currentItem);
         _currentItem = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_useBtn);
         _useBtn = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
      }
   }
}

