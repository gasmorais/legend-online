package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.KingContractTemplateInfo;
   
   public class KingContraceCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function KingContraceCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : KingContractTemplateInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@Id == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,KingContractTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

