package revenge.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.datas.templates.RevengeRoadTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   
   public class RevengeAreaBox extends Component
   {
      
      public var _rewardBox:Bitmap;
      
      public var _getFlag:Bitmap;
      
      private var _hasGet:Boolean;
      
      private var _idx:int;
      
      private var _enable:Boolean;
      
      private var _gray:Array;
      
      public function RevengeAreaBox()
      {
         super();
         initView();
         hasGet = false;
      }
      
      public function get hasGet() : Boolean
      {
         return _hasGet;
      }
      
      public function set hasGet(param1:Boolean) : void
      {
         _hasGet = param1;
         _getFlag.visible = _hasGet;
      }
      
      private function initView() : void
      {
         _rewardBox = ComponentFactory.Instance.creatBitmap("asset.revengeroad.rewardBox");
         _getFlag = ComponentFactory.Instance.creatBitmap("asset.revengeroad.getFlag");
         addChild(_rewardBox);
         addChild(_getFlag);
         _gray = [UIFilter.getGrayFilter()];
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_rewardBox);
         _rewardBox = null;
         ObjectUtils.disposeObject(_getFlag);
         _getFlag = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         _gray = null;
      }
      
      public function get idx() : int
      {
         return _idx;
      }
      
      public function set idx(param1:int) : void
      {
         _idx = param1;
         var _loc4_:RevengeRoadTempInfo = TempleteManager.instance.revengeRoadTempCate.getTempInfo(_idx * 10);
         var _loc5_:String = _loc4_.Name;
         var _loc2_:String = _loc5_ + "\n";
         var _loc6_:int = 0;
         var _loc3_:Array = TempleteManager.instance.revengeRoadAreaBoxCate.getTemplatesAry(_idx);
         for each(var _loc7_:CommonDropTempInfo in _loc3_)
         {
            _loc6_++;
            _loc2_ += TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc7_.itemId).TemplateName + "×" + _loc7_.count;
            if(_loc6_ % 3 == 0)
            {
               _loc2_ += "\n";
            }
            if(_loc6_ < _loc3_.length)
            {
               _loc2_ += ",";
            }
         }
         _loc2_ += "\n" + LanguageMgr.GetTranslation("revengeroad.main.text11",_loc5_);
         tipData = _loc2_;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         _enable = param1;
         if(_enable)
         {
            this.filters = null;
         }
         else
         {
            this.filters = _gray;
         }
      }
   }
}

