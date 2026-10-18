package buildings.transferbuilding.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.planeswar.PlanesWarModel;
   import mvc.module.planeswar.info.PlanesInfo;
   import yishi.GlobalConfig;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.PlanesTemplateInfo;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PlanesItemView extends Sprite implements Disposeable, IManualSize
   {
      
      private var back:Image;
      
      private var planesName:FilterFrameText;
      
      private var precent:FilterFrameText;
      
      private var _remainTimeText:FilterFrameText;
      
      private var giveupBtn:BaseButton;
      
      private var addLifeBtn:BaseButton;
      
      private var transferBtn:BaseButton;
      
      private var _incomeImage:Image;
      
      private var lifeContiner:StripView;
      
      private var _data:PlanesInfo;
      
      private var planesMapTempInfo:PlanesTemplateInfo;
      
      private var addLifeItemTempId:int;
      
      private var addLifeItemTempName:String;
      
      private var addLifeTime:int;
      
      private var _planesTypeList:Array;
      
      private var bInfo:BuildInfo;
      
      private var warpConstInfo:ConfigInfosTempInfo;
      
      public function PlanesItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,493,52);
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("planesItemView.back");
         planesName = ComponentFactory.Instance.creatComponentByStylename("planesItemView.planesName");
         precent = ComponentFactory.Instance.creatComponentByStylename("planesItemView.precent");
         _remainTimeText = ComponentFactory.Instance.creatComponentByStylename("planesItemView.remainTimeText");
         lifeContiner = ComponentFactory.Instance.creatCustomObject("planesItemView.lifeContiner");
         giveupBtn = ComponentFactory.Instance.creatComponentByStylename("planesItemView.giveupBtn");
         addLifeBtn = ComponentFactory.Instance.creatComponentByStylename("planesItemView.addLifeBtn");
         transferBtn = ComponentFactory.Instance.creatComponentByStylename("planesItemView.transferBtn");
         _incomeImage = ComponentFactory.Instance.creatComponentByStylename("planesListView.IncomImage");
         _incomeImage.visible = false;
         addChild(back);
         addChild(planesName);
         addChild(precent);
         lifeContiner.addChild(_remainTimeText);
         addChild(lifeContiner);
         addChild(giveupBtn);
         addChild(addLifeBtn);
         addChild(transferBtn);
         addChild(_incomeImage);
         giveupBtn.tipData = LanguageMgr.GetTranslation("planesItemView.giveupBtn.tipText");
         addLifeBtn.tipData = LanguageMgr.GetTranslation("planesItemView.addLifeBtn.tipText");
         bInfo = BuildingManager.instance.getBuildingInfoBySonType(1511);
         warpConstInfo = TempleteManager.instance.getConfigInfoByConfigName("planes_warp_energy");
         refreshView();
      }
      
      private function addEvent() : void
      {
         giveupBtn.addEventListener("click",__giveupClickHandler);
         addLifeBtn.addEventListener("click",__addLifeClickHandler);
         transferBtn.addEventListener("click",__transferClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(giveupBtn)
         {
            giveupBtn.removeEventListener("click",__giveupClickHandler);
         }
         if(addLifeBtn)
         {
            addLifeBtn.removeEventListener("click",__addLifeClickHandler);
         }
         if(transferBtn)
         {
            transferBtn.removeEventListener("click",__transferClickHandler);
         }
      }
      
      private function __giveupClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(PlayerManager.instance.currentPlayerModel.playerInfo.hasVicePassword == 1 && !GlobalConfig.isConfirmPassword)
         {
            FrameControllerManager.instance.openControllerByInfo("vicepassword",3);
         }
         else
         {
            SimpleAlertHelper.instance.data = [giveupResponse];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("planesItemView.giveup.alertTip");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2);
         }
      }
      
      private function __transferClickHandler(param1:MouseEvent) : void
      {
         if(bInfo.property1 < parseInt(warpConstInfo.ConfigValue))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("planesItemView.transfer.alertTip"));
            return;
         }
         PlanesWarManager.instance.sendPlanesOpMsg(15,[_data.planesId]);
      }
      
      private function giveupResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            PlanesWarManager.instance.sendPlanesOpMsg(18,[_data.planesId]);
         }
      }
      
      private function __addLifeClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc3_:Array = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonType(605);
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(planesMapTempInfo.AddLifeItem);
         if(_loc2_)
         {
            addLifeItemTempId = planesMapTempInfo.AddLifeItem;
            addLifeItemTempName = _loc2_.TemplateName;
            addLifeTime = _loc2_.Property1;
         }
         if(todayNeedAlertForBuy(SharedManager.instance.planesBuyLifeAlertDate))
         {
            showBuyLifeTips();
         }
         else
         {
            PlanesWarManager.instance.sendPlanesOpMsg(17,[_data.planesId,addLifeItemTempId]);
         }
      }
      
      private function showBuyLifeTips() : void
      {
         var _loc4_:TodayNotAlertFrame = null;
         var _loc3_:String = LanguageMgr.GetTranslation("planesItemView.addLife.alertTip",addLifeItemTempName,addLifeTime);
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc2_:Boolean = true;
         _loc2_ = todayNeedAlertForBuy(SharedManager.instance.planesBuyLifeAlertDate);
         if(_loc2_)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert2");
            _loc4_.show(_loc3_,_loc1_,__showBuyLifeTipResult,null,"center",2,true);
            return;
         }
      }
      
      private function __showBuyLifeTipResult(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.planesBuyLifeAlertDate = new Date();
            SharedManager.instance.saveBuyLifeAlertDate();
         }
         PlanesWarManager.instance.sendPlanesOpMsg(17,[_data.planesId,addLifeItemTempId]);
      }
      
      private function todayNeedAlertForBuy(param1:Date) : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         if(param1)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == param1.fullYear && _loc2_.month == param1.month && _loc2_.date == param1.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      public function set data(param1:PlanesInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:SimpleDictionary = null;
         cleanData();
         if(!_data)
         {
            return;
         }
         giveupBtn.visible = transferBtn.visible = addLifeBtn.visible = lifeContiner.visible = true;
         lifeContiner.visible = true;
         planesMapTempInfo = TempleteManager.instance.planesTemplateCate.getTemplateByID(_data.planesTemId);
         planesName.text = planesMapTempInfo.PlanesName;
         planesName.y = 16 - (planesName.numLines - 1) * 6;
         precent.text = _data.planesProcess + "%";
         _remainTimeText.text = (_data.lifePoint / planesMapTempInfo.LifePoint * 100).toFixed(2) + "%";
         var _loc3_:Number = _data.lifeReduce / planesMapTempInfo.LifePoint;
         lifeContiner.tipData = LanguageMgr.GetTranslation("planesItemView.life.alertTipText",(_loc3_ * 100).toFixed(2));
         transferBtn.tipData = LanguageMgr.GetTranslation("planesItemView.transferBtn.tipText",warpConstInfo.ConfigValue);
         var _loc4_:SimpleDictionary = PlanesWarManager.instance.model.getSinglePlanesRewardsById(_data.planesId);
         var _loc5_:Boolean = false;
         for each(var _loc2_:int in _loc4_)
         {
            if(_loc2_ > 0)
            {
               _loc5_ = true;
               break;
            }
         }
         _incomeImage.visible = _loc5_;
         if(_loc5_)
         {
            _loc1_ = new SimpleDictionary();
            _loc1_[_data.planesId] = _loc4_;
            _incomeImage.tipStyle = "yishi.view.tips.PlanesRewardTip";
            _incomeImage.tipData = {"dic":_loc1_};
         }
      }
      
      private function cleanData() : void
      {
         planesName.text = "";
         precent.text = "";
         _remainTimeText.text = "";
         giveupBtn.visible = transferBtn.visible = addLifeBtn.visible = false;
         lifeContiner.visible = false;
         _incomeImage.visible = false;
      }
      
      private function get planesWarModel() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _planesTypeList = null;
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(planesName)
         {
            ObjectUtils.disposeObject(planesName);
         }
         planesName = null;
         if(addLifeBtn)
         {
            ObjectUtils.disposeObject(addLifeBtn);
         }
         addLifeBtn = null;
         if(precent)
         {
            ObjectUtils.disposeObject(precent);
         }
         precent = null;
         if(lifeContiner)
         {
            ObjectUtils.disposeObject(lifeContiner);
         }
         lifeContiner = null;
         if(_remainTimeText)
         {
            ObjectUtils.disposeObject(_remainTimeText);
         }
         _remainTimeText = null;
         if(giveupBtn)
         {
            ObjectUtils.disposeObject(giveupBtn);
         }
         giveupBtn = null;
         if(transferBtn)
         {
            ObjectUtils.disposeObject(transferBtn);
         }
         transferBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

