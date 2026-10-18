package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.StarareaRoadsTemplate;
   
   public class StarareaRoadsTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _dic_id:Dictionary;
      
      private var _dic_node_nodes:Dictionary;
      
      private var _tempXml:XML;
      
      public function StarareaRoadsTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         _dic_id = new Dictionary();
         _dic_node_nodes = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:StarareaRoadsTemplate = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc7_:String = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc6_ = int(_loc1_.@Node1);
               _loc3_ = int(_loc1_.@Node2);
               if(_loc6_ < _loc3_)
               {
                  _loc7_ = _loc6_ + "_" + _loc3_;
               }
               else
               {
                  _loc7_ = _loc3_ + "_" + _loc6_;
               }
               _loc2_ = createNode(_loc1_,StarareaRoadsTemplate,_tempXml) as StarareaRoadsTemplate;
               _dic[_loc7_] = _loc2_;
               _dic_id[_loc2_.Id] = _loc2_;
               _loc4_ = _dic_node_nodes[_loc6_];
               if(_loc4_ == null)
               {
                  _loc4_ = [];
                  _dic_node_nodes[_loc6_] = _loc4_;
               }
               if(_loc4_.indexOf(_loc3_) == -1)
               {
                  _loc4_.push(_loc3_);
               }
               _loc5_ = _dic_node_nodes[_loc3_];
               if(_loc5_ == null)
               {
                  _loc5_ = [];
                  _dic_node_nodes[_loc3_] = _loc5_;
               }
               if(_loc5_.indexOf(_loc6_) == -1)
               {
                  _loc5_.push(_loc6_);
               }
            }
         }
         _list = null;
      }
      
      public function getTemplete(param1:int, param2:int) : StarareaRoadsTemplate
      {
         var _loc3_:StarareaRoadsTemplate = null;
         var _loc4_:String = param1 + "_" + param2;
         _loc3_ = _dic[_loc4_];
         if(!_loc3_)
         {
            _loc4_ = param2 + "_" + param1;
            _loc3_ = _loc3_ = _dic[_loc4_];
         }
         return _loc3_;
      }
      
      public function getTempleteById(param1:int) : StarareaRoadsTemplate
      {
         return _dic_id[param1];
      }
      
      public function getNodesByNodeid(param1:int) : Array
      {
         return _dic_node_nodes[param1];
      }
   }
}

