package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.GoddessFormationSkillTemp;
   
   public class GoddessFormationSkillTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public var LV:Array;
      
      public function GoddessFormationSkillTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         LV = [];
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               LV.push(int(_loc1_.@MinLevel));
               _loc2_ = _loc1_.@MinLevel + "";
               _dic[_loc2_] = createNode(_loc1_,GoddessFormationSkillTemp,_tempXml) as GoddessFormationSkillTemp;
            }
         }
         LV.sort(16);
         _list = null;
      }
      
      public function getTemplates() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:GoddessFormationSkillTemp in _dic)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getTemplateByLevel(param1:int) : GoddessFormationSkillTemp
      {
         return _dic[param1 + ""];
      }
   }
}

