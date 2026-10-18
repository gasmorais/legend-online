package yishi.datas.templates
{
   import yishi.datas.goods.GoodsInfo;
   
   public class SuiteTempInfo
   {
      
      public var TemplateId:int;
      
      public var TemplateName:String;
      
      public var Template1:int;
      
      public var Template2:int;
      
      public var Template3:int;
      
      public var Template4:int;
      
      public var Template5:int;
      
      public var Template6:int;
      
      public var Template7:int;
      
      public var Template8:int;
      
      public var Template1s:int;
      
      public var Template2s:int;
      
      public var Template3s:int;
      
      public var Template4s:int;
      
      public var Template5s:int;
      
      public var Template6s:int;
      
      public var Template7s:int;
      
      public var Template8s:int;
      
      public var Property1:int;
      
      public var Property2:int;
      
      public var Property3:int;
      
      public var Property4:int;
      
      public var Property5:int;
      
      public var Property6:int;
      
      public var Property7:int;
      
      public var Property8:int;
      
      public function SuiteTempInfo()
      {
         super();
      }
      
      public function get tempArr() : Array
      {
         var _loc1_:Array = [];
         if(Template1 != 0)
         {
            _loc1_.push("Template1");
         }
         if(Template2 != 0)
         {
            _loc1_.push("Template2");
         }
         if(Template3 != 0)
         {
            _loc1_.push("Template3");
         }
         if(Template4 != 0)
         {
            _loc1_.push("Template4");
         }
         if(Template5 != 0)
         {
            _loc1_.push("Template5");
         }
         if(Template6 != 0)
         {
            _loc1_.push("Template6");
         }
         if(Template7 != 0)
         {
            _loc1_.push("Template7");
         }
         if(Template8 != 0)
         {
            _loc1_.push("Template8");
         }
         return _loc1_;
      }
      
      public function get propertyArr() : Array
      {
         var _loc1_:Array = [];
         if(Property1 != 0)
         {
            _loc1_.push("Property1");
         }
         if(Property2 != 0)
         {
            _loc1_.push("Property2");
         }
         if(Property3 != 0)
         {
            _loc1_.push("Property3");
         }
         if(Property4 != 0)
         {
            _loc1_.push("Property4");
         }
         if(Property5 != 0)
         {
            _loc1_.push("Property5");
         }
         if(Property6 != 0)
         {
            _loc1_.push("Property6");
         }
         if(Property7 != 0)
         {
            _loc1_.push("Property7");
         }
         if(Property8 != 0)
         {
            _loc1_.push("Property8");
         }
         return _loc1_;
      }
      
      public function get suitCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 1;
         while(_loc2_ <= 8)
         {
            if(this["Template" + _loc2_] != 0 || this["Template" + _loc2_ + "s"] != 0)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function existCount(param1:Array) : int
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         for each(var _loc5_:GoodsInfo in param1)
         {
            _loc2_.push(_loc5_.templateId);
         }
         var _loc3_:int = 0;
         _loc4_ = 1;
         while(_loc4_ <= 8)
         {
            if(_loc2_.indexOf(this["Template" + _loc4_]) >= 0 || _loc2_.indexOf(this["Template" + _loc4_ + "s"]) >= 0)
            {
               _loc3_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
   }
}

