package redemptionroad.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RedemptionRoadManager;
   import mvc.module.redemptionroad.RedemptionRoadModel;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   
   public class RedemptionRoadDiffItem extends Component
   {
      
      private var _itemBack:ScaleFrameImage;
      
      private var _diffImage:ScaleFrameImage;
      
      private var _selectBg:Bitmap;
      
      private var _cdBack:MutipleImage;
      
      private var _cdText:FilterFrameText;
      
      private var _cdBtn:BaseButton;
      
      private var _clearanceImage:Bitmap;
      
      private var index:int;
      
      private var configCost:int;
      
      public function RedemptionRoadDiffItem(param1:int)
      {
         super();
         index = param1;
         initView();
      }
      
      private function initView() : void
      {
         _itemBack = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadDiffItem.itemBack");
         _diffImage = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadDiffItem.diffImage");
         _selectBg = ComponentFactory.Instance.creatBitmap("asset.RedemptionRoadDiffItem.selectBg");
         _cdBack = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadDiffItem.cdBack");
         _cdText = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadDiffItem.cdText");
         _cdBtn = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadDiffItem.cdBtn");
         _clearanceImage = ComponentFactory.Instance.creatBitmap("asset.RedemptionRoadDiffItem.clearanceImage");
         addChild(_itemBack);
         addChild(_diffImage);
         addChild(_selectBg);
         addChild(_cdBack);
         addChild(_cdText);
         addChild(_cdBtn);
         addChild(_clearanceImage);
         _itemBack.setFrame(index);
         _diffImage.setFrame(index);
         _selectBg.visible = false;
         _cdBack.visible = false;
         _cdBtn.visible = false;
         _clearanceImage.visible = false;
         _cdText.text = "";
         configCost = ConfigInfoManager.instance.getRedemptionRoadCostPoint();
      }
      
      private function addEvent() : void
      {
         _cdBtn.addEventListener("click",__cdClickHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updateTimeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_cdBtn)
         {
            _cdBtn.removeEventListener("click",__cdClickHandler);
         }
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateTimeHandler);
      }
      
      private function __cdClickHandler(param1:MouseEvent) : void
      {
         var _loc7_:int = (model.cdEndTime.time - playerModel.sysCurtime.time) / 1000 / 60;
         var _loc2_:int = int(Math.ceil(_loc7_ / 10)) * configCost;
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("RedemptionRoadDiffItem.cdCost.alert",_loc2_);
         SimpleAlertHelper.instance.data = [cdConfirmHandler,_loc2_];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_,true,true,false);
      }
      
      private function cdConfirmHandler(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(!param1)
         {
            return;
         }
         if(!LogicUtils.judgePointEnoughToShowPay(param3,false))
         {
            return;
         }
         RedemptionRoadManager.instance.sendRedemptionRoadRequest(2);
      }
      
      private function __updateTimeHandler(param1:PlayerEvent) : void
      {
         var _loc2_:int = (model.cdEndTime.time - playerModel.sysCurtime.time) / 1000;
         if(_loc2_ > 0)
         {
            _cdText.text = DateFormatter.getConsortiaCountDate(_loc2_);
         }
         else
         {
            refreshView();
         }
      }
      
      public function refreshView() : void
      {
         clean();
         if(index == model.difficulty)
         {
            if(model.isCding)
            {
               addEvent();
               _cdBack.visible = true;
               _cdBtn.visible = true;
               __updateTimeHandler(null);
            }
            else
            {
               removeEvent();
               _selectBg.visible = true;
               _itemBack.filters = [];
               _diffImage.filters = [];
            }
            _clearanceImage.visible = model.isClearance;
         }
         else if(index < model.difficulty)
         {
            _itemBack.filters = [];
            _diffImage.filters = [];
            _clearanceImage.visible = true;
         }
      }
      
      private function clean() : void
      {
         removeEvent();
         _selectBg.visible = false;
         _cdBack.visible = false;
         _cdBtn.visible = false;
         _clearanceImage.visible = false;
         _cdText.text = "";
         _itemBack.filters = [UIFilter.getGrayFilter()];
         _diffImage.filters = [UIFilter.getGrayFilter()];
      }
      
      private function get model() : RedemptionRoadModel
      {
         return RedemptionRoadManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBack);
         _itemBack = null;
         ObjectUtils.disposeObject(_diffImage);
         _diffImage = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_cdBack);
         _cdBack = null;
         ObjectUtils.disposeObject(_cdText);
         _cdText = null;
         ObjectUtils.disposeObject(_cdBtn);
         _cdBtn = null;
         ObjectUtils.disposeObject(_clearanceImage);
         _clearanceImage = null;
         super.dispose();
      }
   }
}

