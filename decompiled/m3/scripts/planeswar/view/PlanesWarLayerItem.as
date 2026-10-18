package planeswar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import mvc.module.planeswar.PlanesWarModel;
   import mvc.module.planeswar.info.PlanesLayerInfo;
   import yishi.datas.templates.PlanesLayerTemplateInfo;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class PlanesWarLayerItem extends Component
   {
      
      private var lightImage:Bitmap;
      
      private var backIcon:ScaleFrameImage;
      
      private var keyIcon:ScaleFrameImage;
      
      private var _data:PlanesLayerInfo;
      
      private var layerTempInfo:PlanesLayerTemplateInfo;
      
      private var keyArr:Array = [4,5,6,7,11,13];
      
      public function PlanesWarLayerItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         lightImage = ComponentFactory.Instance.creatBitmap("asset.PlanesWarLayerItem.lightImage");
         backIcon = ComponentFactory.Instance.creatComponentByStylename("PlanesWarLayerItem.backIcon");
         keyIcon = ComponentFactory.Instance.creatComponentByStylename("PlanesWarLayerItem.keyIcon");
         addChild(lightImage);
         addChild(backIcon);
         addChild(keyIcon);
         backIcon.setFrame(1);
         keyIcon.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         backIcon.addEventListener("click",__layerTransferClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(backIcon)
         {
            backIcon.removeEventListener("click",__layerTransferClickHandler);
         }
      }
      
      private function __layerTransferClickHandler(param1:MouseEvent) : void
      {
         if(!_data.isActived)
         {
            return;
         }
         if(_data.layerId == model.planesWarInfo.layerId)
         {
            return;
         }
         PlanesWarManager.instance.sendPlanesOpMsg(36,[_data.layerId]);
      }
      
      public function set data(param1:PlanesLayerInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         layerTempInfo = TempleteManager.instance.planesLayerTemplateCate.getTemplateByID(_data.layerTempId);
         if(!layerTempInfo)
         {
            return;
         }
         lightImage.visible = _data.layerId == model.planesWarInfo.layerId;
         keyIcon.setFrame(keyArr.indexOf(layerTempInfo.IconType) + 1);
         if(_data.occupyUserId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            backIcon.setFrame(2);
         }
         else
         {
            backIcon.setFrame(1);
         }
         if(!_data.isActived)
         {
            backIcon.setFrame(3);
            keyIcon.visible = false;
            backIcon.buttonMode = false;
         }
         else
         {
            keyIcon.visible = _data.iconState <= 0;
            backIcon.buttonMode = true;
         }
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(lightImage);
         lightImage = null;
         ObjectUtils.disposeObject(backIcon);
         backIcon = null;
         ObjectUtils.disposeObject(keyIcon);
         keyIcon = null;
         super.dispose();
      }
   }
}

