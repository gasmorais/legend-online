package yishi.datas.templates.cate
{
   import org.serialize.XmlCoder;
   import yishi.utils.ClassFactory;
   
   public class TemplateCate
   {
      
      protected static var coder:XmlCoder = new XmlCoder();
      
      protected var _list:XMLList;
      
      protected var _currentCount:int = 0;
      
      public function TemplateCate(param1:XMLList)
      {
         super();
         _list = param1;
      }
      
      protected function createNode(param1:XML, param2:Class, param3:XML = null) : Object
      {
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc4_:Object = null;
         if(param3 == null)
         {
            _loc5_ = ClassFactory.createInstanceIII(param2,param1);
         }
         else
         {
            _loc6_ = {};
            _loc4_ = coder.decode(param1,_loc6_);
            _loc5_ = ClassFactory.createInstanceII(param2,_loc4_,param3);
         }
         _currentCount = _currentCount + 1;
         if(_currentCount == _list.length())
         {
            _list = null;
         }
         return _loc5_;
      }
      
      protected function checkFirst() : void
      {
      }
   }
}

