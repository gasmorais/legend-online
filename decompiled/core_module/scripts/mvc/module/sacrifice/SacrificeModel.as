package mvc.module.sacrifice
{
   import com.road.yishi.proto.active.SacrificeRspMsg;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.TempleteManager;
   
   public class SacrificeModel
   {
      
      private var _sacrificeInfo:SacrificeInfo;
      
      public function SacrificeModel()
      {
         super();
         _sacrificeInfo = new SacrificeInfo();
         readSacrificeGoods();
      }
      
      public function updateInfo(param1:SacrificeRspMsg) : void
      {
         switch(param1.opType - 1)
         {
            case 0:
               _sacrificeInfo.op = param1.opType;
               _sacrificeInfo.times = param1.times;
               readReward(param1);
               break;
            case 1:
               _sacrificeInfo.op = param1.opType;
               readReward(param1);
               break;
            case 2:
               _sacrificeInfo.op = param1.opType;
               _sacrificeInfo.times = param1.times;
               readReward(param1);
               break;
            case 3:
            case 4:
               _sacrificeInfo.op = param1.opType;
         }
      }
      
      private function getLevelUpGp(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = TempleteManager.instance.getTemplatesByType(108);
         _loc4_.sortOn("Grades",16);
         _sacrificeInfo.maxLevel = _loc4_[_loc4_.length - 1].Grades;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(_loc4_[_loc3_].Grades == param1 + 1)
            {
               _loc2_ = int(_loc4_[_loc3_].Data);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function readReward(param1:SacrificeRspMsg) : void
      {
         var _loc4_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc2_:Array = null;
         _sacrificeInfo.rewardArr = [];
         if(param1.tempIds == "" || param1.tempIds == null)
         {
            return;
         }
         var _loc3_:Array = param1.tempIds.split("|");
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = new GoodsInfo();
            _loc2_ = (_loc3_[_loc4_] as String).split("&");
            _loc5_.templateId = _loc2_[0];
            _loc5_.count = _loc2_[1];
            _sacrificeInfo.rewardArr.push(_loc5_);
            _loc4_++;
         }
      }
      
      private function readSacrificeGoods() : void
      {
         var _loc3_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc4_:Array = null;
         _sacrificeInfo.sacrificeGoodsArr = [];
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("sacrifice_items_reward");
         var _loc1_:Array = _loc2_.ConfigValue.split("|");
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc5_ = new GoodsInfo();
            _loc4_ = (_loc1_[_loc3_] as String).split("&");
            _loc5_.templateId = _loc4_[1];
            _sacrificeInfo.sacrificeGoodsArr.push(_loc5_);
            _loc3_++;
         }
      }
      
      public function get sacrificeInfo() : SacrificeInfo
      {
         return _sacrificeInfo;
      }
      
      public function set sacrificeInfo(param1:SacrificeInfo) : void
      {
         _sacrificeInfo = param1;
      }
   }
}

