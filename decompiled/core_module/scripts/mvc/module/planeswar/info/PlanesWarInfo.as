package mvc.module.planeswar.info
{
   import yishi.datas.templates.PlanesLayerTemplateInfo;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.TempleteManager;
   
   public class PlanesWarInfo
   {
      
      public var planesTempId:int;
      
      public var layerId:int;
      
      public var dead:Boolean;
      
      public var reviveLeft:int;
      
      public var posX:int;
      
      public var posY:int;
      
      public var goldKeyCount:int;
      
      public var silverKeyCount:int;
      
      public var eventInfo:PlanesEventInfo;
      
      public var stamp:int;
      
      public var gridArr:Array = [];
      
      public var isHideLayer:Boolean = false;
      
      private var _layerTempId:int;
      
      public function PlanesWarInfo()
      {
         super();
         eventInfo = new PlanesEventInfo();
      }
      
      public function get layerTempId() : int
      {
         return _layerTempId;
      }
      
      public function set layerTempId(param1:int) : void
      {
         var _loc3_:Array = null;
         _layerTempId = param1;
         var _loc2_:PlanesLayerTemplateInfo = TempleteManager.instance.planesLayerTemplateCate.getTemplateByID(_layerTempId);
         if(_loc2_)
         {
            _loc3_ = _loc2_.Size.split("_");
            PlanesWarManager.instance.model.currentSize = _loc2_.Size;
            PlanesWarManager.instance.model.COLUMN_NUM = _loc3_[0];
            PlanesWarManager.instance.model.ROW_NUM = _loc3_[1];
            isHideLayer = _loc2_.IconType == 7;
         }
      }
      
      public function get layerInfo() : PlanesLayerInfo
      {
         return PlanesWarManager.instance.model.getPlanesLayerInfoById(layerId);
      }
   }
}

