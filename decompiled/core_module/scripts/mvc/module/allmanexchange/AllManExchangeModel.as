package mvc.module.allmanexchange
{
   import com.road.yishi.proto.active.AllExchangeItemInfoMsg;
   import com.road.yishi.proto.active.AllExchangeMsg;
   import manager.LanguageMgr;
   import ui.toptoolbar.TopToolsBar;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class AllManExchangeModel
   {
      
      public var id:String;
      
      public var begin:String;
      
      public var end:String;
      
      public var isopen:Boolean;
      
      public var allPoint:int;
      
      public var boxChangeCount:Array;
      
      public var allChangeCount:int;
      
      public var changeItemCount:int;
      
      public var changeNeedPoint:Array;
      
      public var point:Array;
      
      public var exchangeCount:Array;
      
      public var totalExchangeCount:String;
      
      public var allPointAward:Array;
      
      public var serverAwardState:Array;
      
      public var boxAward:Array;
      
      public var serverAward:Array;
      
      public var changeItem:int;
      
      public function AllManExchangeModel()
      {
         super();
      }
      
      public function update(param1:AllExchangeMsg) : void
      {
         if(param1.hasId)
         {
            id = param1.id;
         }
         if(param1.hasBegin)
         {
            begin = param1.begin;
         }
         if(param1.hasEnd)
         {
            end = param1.end;
         }
         if(param1.hasIsopen)
         {
            if(isopen != param1.isopen)
            {
               isopen = param1.isopen;
               TopToolsBar.instance.allManExchangeState = param1.isopen ? 1 : 0;
            }
         }
         if(param1.hasAllPoint)
         {
            allPoint = param1.allPoint;
         }
         if(param1.hasBoxChangeCount)
         {
            boxChangeCount = param1.boxChangeCount.split(",");
         }
         if(param1.hasAllChangeCount)
         {
            allChangeCount = param1.allChangeCount;
         }
         if(param1.hasPoint)
         {
            point = param1.point.split(",");
         }
         if(param1.hasExchangeCount)
         {
            exchangeCount = param1.exchangeCount.split(",");
         }
         if(param1.hasTotalExchangeCount)
         {
            totalExchangeCount = param1.totalExchangeCount;
         }
         if(param1.hasAllPointAward)
         {
            allPointAward = param1.allPointAward.split(",");
         }
         if(param1.boxAward.length)
         {
            boxAward = param1.boxAward;
         }
         if(param1.serverAward.length)
         {
            serverAward = param1.serverAward;
         }
         if(param1.hasChangeItem)
         {
            changeItem = param1.changeItem;
         }
         if(param1.hasChangeNeedPoint)
         {
            changeNeedPoint = param1.changeNeedPoint.split(",");
         }
         if(param1.hasServerAwardState)
         {
            serverAwardState = param1.serverAwardState.split(",");
         }
         if(param1.hasChangeItemCount)
         {
            changeItemCount = param1.changeItemCount;
         }
      }
      
      public function getBigBoxTip(param1:int) : String
      {
         var _loc6_:AllExchangeItemInfoMsg = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc2_:String = "";
         var _loc3_:String = "";
         _loc5_ = 0;
         while(_loc5_ < boxAward.length)
         {
            _loc6_ = boxAward[_loc5_] as AllExchangeItemInfoMsg;
            if(_loc6_.index == param1)
            {
               _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc6_.itemId);
               if(_loc6_.randomType == 1)
               {
                  if(_loc2_ == "")
                  {
                     _loc2_ += LanguageMgr.GetTranslation("allmainexchange.str13") + "\n";
                  }
                  _loc2_ += _loc4_.TemplateName + " x " + _loc6_.itemCount + "\n";
               }
               else
               {
                  if(_loc3_ == "")
                  {
                     _loc3_ += LanguageMgr.GetTranslation("allmainexchange.str14") + "\n";
                  }
                  _loc3_ += _loc4_.TemplateName + " x " + _loc6_.itemCount + "\n";
               }
            }
            _loc5_++;
         }
         return _loc2_ + _loc3_;
      }
      
      public function getSmallBoxTip(param1:int) : String
      {
         var _loc5_:AllExchangeItemInfoMsg = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc2_:String = "";
         _loc4_ = 0;
         while(_loc4_ < serverAward.length)
         {
            _loc5_ = serverAward[_loc4_] as AllExchangeItemInfoMsg;
            if(_loc5_.index == param1)
            {
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_.itemId);
               _loc2_ += _loc3_.TemplateName + " x " + _loc5_.itemCount + "\n";
            }
            _loc4_++;
         }
         return _loc2_;
      }
   }
}

