package dragonBones.objects
{
   internal final class DataList
   {
      
      private var _dataDic:Object;
      
      public var dataNames:Vector.<String>;
      
      public function DataList()
      {
         super();
         this._dataDic = {};
         this.dataNames = new Vector.<String>();
      }
      
      public function dispose() : void
      {
         this._dataDic = {};
         this.dataNames.length = 0;
      }
      
      public function getData(param1:String) : Object
      {
         return this._dataDic[param1];
      }
      
      public function getDataAt(param1:int) : Object
      {
         return this._dataDic[this.dataNames[param1]];
      }
      
      public function addData(param1:Object, param2:String) : void
      {
         if(Boolean(param1) && Boolean(param2))
         {
            this._dataDic[param2] = param1;
            if(this.dataNames.indexOf(param2) < 0)
            {
               this.dataNames.push(param2);
            }
         }
      }
      
      public function removeData(param1:Object) : void
      {
         var _loc2_:String = null;
         if(param1)
         {
            for(_loc2_ in this._dataDic)
            {
               if(this._dataDic[_loc2_] == param1)
               {
                  this.removeDataByName(_loc2_);
                  return;
               }
            }
         }
      }
      
      public function removeDataByName(param1:String) : void
      {
         var _loc2_:Object = this._dataDic[param1];
         if(_loc2_)
         {
            delete this._dataDic[param1];
            this.dataNames.splice(this.dataNames.indexOf(param1),1);
         }
      }
   }
}

