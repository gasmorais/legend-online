package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.tips.goods.EquipTip;
   
   public class IntensifyTip extends BaseTip
   {
      
      private var _intensifyIcon:Bitmap;
      
      private var _goodstip1:EquipTip;
      
      private var _goodstip2:EquipTip;
      
      public function IntensifyTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.parent && _bg.parent.removeChild(_bg);
         _goodstip1 = new EquipTip();
         _goodstip2 = new EquipTip();
         _goodstip2.x = _goodstip1.width + 80;
         _intensifyIcon = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.IntensifyIcon");
         addChild(_goodstip1);
         addChild(_goodstip2);
         addChild(_intensifyIcon);
      }
      
      override public function set tipData(param1:Object) : void
      {
         _data = param1;
         _goodstip1.tipData = _data;
         var _loc2_:GoodsInfo = _data as GoodsInfo;
         if(_loc2_)
         {
            if(_loc2_.strengthenGrade >= _loc2_.templateInfo.StrengthenMax)
            {
               _intensifyIcon.parent && _intensifyIcon.parent.removeChild(_intensifyIcon);
               _goodstip2.parent && _goodstip2.parent.removeChild(_goodstip2);
               return;
            }
            _goodstip2.parent || addChild(_goodstip2);
            _intensifyIcon.parent || addChild(_intensifyIcon);
            _intensifyIcon.x = _goodstip1.x + _goodstip1.width - 16;
            _intensifyIcon.y = _goodstip1.y + (_goodstip1.height - _intensifyIcon.height) / 2;
            _loc2_ = getNextGrade(_loc2_);
            _goodstip2.tipData = _loc2_;
            _goodstip2.x = _goodstip1.x + _goodstip1.width + 29;
         }
      }
      
      private function getNextGrade(param1:GoodsInfo) : GoodsInfo
      {
         var _loc2_:GoodsInfo = new GoodsInfo();
         ObjectUtils.copyProperties(_loc2_,param1,true);
         _loc2_.strengthenGrade = param1.strengthenGrade + 1;
         _loc2_.mouldGrade = param1.mouldGrade;
         _loc2_.mouldRank = param1.mouldRank;
         _loc2_.mouldStar = param1.mouldStar;
         _loc2_.isBinds = true;
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         if(_intensifyIcon)
         {
            ObjectUtils.disposeObject(_intensifyIcon);
         }
         _intensifyIcon = null;
         if(_goodstip1)
         {
            ObjectUtils.disposeObject(_goodstip1);
         }
         _goodstip1 = null;
         if(_goodstip2)
         {
            ObjectUtils.disposeObject(_goodstip2);
         }
         _goodstip2 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

