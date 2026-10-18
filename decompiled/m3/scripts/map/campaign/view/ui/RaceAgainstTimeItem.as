package map.campaign.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.view.community.BaseItemView;
   
   public class RaceAgainstTimeItem extends Sprite implements Disposeable
   {
      
      private var _floorTxt:FilterFrameText;
      
      private var _HBox:HBox;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timeHBox:HBox;
      
      public function RaceAgainstTimeItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _floorTxt = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeItem.floorTxt");
         _HBox = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeItem.HBox");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeItem.timeTxt");
         _timeHBox = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeItem.timeHBox");
         addChild(_floorTxt);
         addChild(_HBox);
         addChild(_timeTxt);
         addChild(_timeHBox);
      }
      
      public function setClearRewards(param1:int, param2:Array) : void
      {
         var _loc3_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc6_:CommonDropTempInfo = null;
         var _loc4_:int = 0;
         _floorTxt.htmlText = LanguageMgr.GetTranslation("RaceAgainstTimeItem.floorTxt.text",param1);
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            _loc6_ = param2[_loc4_];
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc6_.itemId;
            _loc5_.count = _loc6_.count;
            _loc3_ = ComponentFactory.Instance.creatCustomObject("raceAgainstTimeItem.itemView");
            _loc3_.data = _loc5_;
            _HBox.addChild(_loc3_);
            _loc4_++;
         }
      }
      
      public function setTimeRewards(param1:int, param2:int, param3:Array) : void
      {
         var _loc4_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc7_:CommonDropTempInfo = null;
         var _loc5_:int = 0;
         _timeTxt.htmlText = LanguageMgr.GetTranslation("RaceAgainstTimeItem.timeTxt.text",param1,param2);
         _loc5_ = 0;
         while(_loc5_ < param3.length)
         {
            _loc7_ = param3[_loc5_];
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc7_.itemId;
            _loc6_.count = _loc7_.count;
            _loc4_ = ComponentFactory.Instance.creatCustomObject("raceAgainstTimeItem.itemView");
            _loc4_.data = _loc6_;
            _timeHBox.addChild(_loc4_);
            _loc5_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_floorTxt);
         _floorTxt = null;
         ObjectUtils.disposeObject(_HBox);
         _HBox = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_timeHBox);
         _timeHBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

