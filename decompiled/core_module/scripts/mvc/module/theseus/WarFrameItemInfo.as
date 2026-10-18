package mvc.module.theseus
{
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.WarframeQuiltyInfo;
   import yishi.datas.templates.WarframeStrengthenInfo;
   import yishi.manager.TempleteManager;
   
   public class WarFrameItemInfo
   {
      
      public var id:int;
      
      public var model:TheseussoulModel;
      
      public var isEquip:Boolean;
      
      public var isExist:Boolean;
      
      public var type:int;
      
      public var objectId:int;
      
      public var pos:int;
      
      public var count:int;
      
      public var newLearnSkill:int;
      
      private var _templateId:int = -1;
      
      private var _warTempInfo:GoodsTemplateInfo;
      
      private var _strengthen:int = -1;
      
      private var _warStrengthTempInfo:WarframeStrengthenInfo;
      
      private var _warStrengthTempInfoNext:WarframeStrengthenInfo;
      
      private var _reform:int = -1;
      
      private var _warReformTempInfo:WarframeQuiltyInfo;
      
      private var _warReformTempInfoNext:WarframeQuiltyInfo;
      
      private var _isLock:Boolean;
      
      public function WarFrameItemInfo()
      {
         super();
      }
      
      public function get warReformTempInfoNext() : WarframeQuiltyInfo
      {
         return _warReformTempInfoNext;
      }
      
      public function get warReformTempInfo() : WarframeQuiltyInfo
      {
         return _warReformTempInfo;
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         _isLock = param1;
      }
      
      public function get reform() : int
      {
         return _reform;
      }
      
      public function set reform(param1:int) : void
      {
         _reform = param1;
         _warReformTempInfo = TempleteManager.instance.theseusEquipQualityTmpl.getTempInfoByIndex(_templateId,_reform);
         _warReformTempInfoNext = TempleteManager.instance.theseusEquipQualityTmpl.getTempInfoByIndex(_templateId,_reform + 1);
      }
      
      public function get warStrengthTempInfo() : WarframeStrengthenInfo
      {
         return _warStrengthTempInfo;
      }
      
      public function get warStrengthTempInfoNext() : WarframeStrengthenInfo
      {
         return _warStrengthTempInfoNext;
      }
      
      public function get strengthen() : int
      {
         return _strengthen;
      }
      
      public function set strengthen(param1:int) : void
      {
         _strengthen = param1;
         _warStrengthTempInfo = TempleteManager.instance.theseusEquipStrengthenTmpl.getTempInfoByIndex(_warTempInfo.Property3,_strengthen);
         _warStrengthTempInfoNext = TempleteManager.instance.theseusEquipStrengthenTmpl.getTempInfoByIndex(_warTempInfo.Property3,_strengthen + 1);
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         _templateId = param1;
         _warTempInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_templateId);
      }
      
      public function get warTempInfo() : GoodsTemplateInfo
      {
         return _warTempInfo;
      }
      
      public function clone() : WarFrameItemInfo
      {
         var _loc1_:WarFrameItemInfo = new WarFrameItemInfo();
         _loc1_.id = id;
         _loc1_.templateId = templateId;
         _loc1_.count = count;
         _loc1_.strengthen = strengthen;
         _loc1_.reform = reform;
         _loc1_.isEquip = isEquip;
         _loc1_.isExist = isExist;
         _loc1_.isLock = isLock;
         _loc1_.pos = pos;
         _loc1_.type = type;
         return _loc1_;
      }
   }
}

