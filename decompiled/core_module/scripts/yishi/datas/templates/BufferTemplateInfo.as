package yishi.datas.templates
{
   public class BufferTemplateInfo
   {
      
      public var Id:int;
      
      public var BufferName:String;
      
      public var AttackData:int;
      
      public var AttackType:int;
      
      public var AttackObject:int;
      
      public var ValidCount:int;
      
      public var Dispel:int;
      
      public var AddWay:int;
      
      public var AttackWay:int;
      
      public var AttackValue:int;
      
      public var Icon:String;
      
      public var ValuePercent:int;
      
      public var Random:int;
      
      public var TalentEffIds:String;
      
      public var CountWay:int;
      
      public var PressCount:int;
      
      public var AddEffect:String;
      
      public var ActionEffect:String;
      
      public var LastEffect:String;
      
      public var Parm3:String;
      
      public var MultiLordsInspireLevel:int;
      
      private var _addEffectArr:Array;
      
      private var _actionEffectArr:Array;
      
      private var _lastEffectArr:Array;
      
      public function BufferTemplateInfo()
      {
         super();
      }
      
      public function getAddEffectArr() : Array
      {
         if(!_addEffectArr)
         {
            _addEffectArr = AddEffect.split(",");
            if(_addEffectArr.length < 1 || _addEffectArr[0] == "" || _addEffectArr[0] == "undefined")
            {
               _addEffectArr[0] = null;
            }
            if(_addEffectArr.length < 2)
            {
               _addEffectArr[1] = 0;
            }
         }
         return _addEffectArr;
      }
      
      public function getActionEffectArr() : Array
      {
         if(!_actionEffectArr)
         {
            _actionEffectArr = ActionEffect.split(",");
            if(_actionEffectArr.length < 1 || _actionEffectArr[0] == "" || _actionEffectArr[0] == "undefined")
            {
               _actionEffectArr[0] = null;
            }
            if(_actionEffectArr.length < 2)
            {
               _actionEffectArr[1] = 0;
            }
         }
         return _actionEffectArr;
      }
      
      public function getLastEffectArr() : Array
      {
         if(!_lastEffectArr)
         {
            _lastEffectArr = LastEffect.split(",");
            if(_lastEffectArr.length < 1 || _lastEffectArr[0] == "" || _lastEffectArr[0] == "undefined")
            {
               _lastEffectArr[0] = null;
            }
            if(_lastEffectArr.length < 2)
            {
               _lastEffectArr[1] = 0;
            }
            if(_lastEffectArr.length < 3)
            {
               _lastEffectArr[2] = 0;
            }
         }
         return _lastEffectArr;
      }
   }
}

