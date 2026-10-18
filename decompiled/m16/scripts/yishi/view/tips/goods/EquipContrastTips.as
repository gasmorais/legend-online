package yishi.view.tips.goods
{
   import bag.helper.GoodsCheck;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.view.tips.BaseTip;
   
   public class EquipContrastTips extends BaseTip
   {
      
      private var _goodstip1:EquipTip;
      
      private var _goodstip2:EquipTip;
      
      private var _goodstip3:EquipTip;
      
      public function EquipContrastTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         _goodstip1 = new EquipTip();
         _goodstip1.y = 25;
         _goodstip2 = new EquipTip();
         _goodstip2.type = 1;
         _goodstip2.y = 25;
         _goodstip3 = new EquipTip();
         _goodstip3.type = 1;
         _goodstip3.y = 25;
      }
      
      override public function set direction(param1:int) : void
      {
         switch(param1)
         {
            case 0:
            case 2:
            case 5:
            case 7:
               _goodstip1.x = 0;
               if(_goodstip2.tipData)
               {
                  _goodstip2.x = _goodstip1.x + _goodstip1.width + 5;
                  if(_goodstip3.tipData)
                  {
                     _goodstip3.x = _goodstip2.x + _goodstip2.width + 5;
                  }
                  break;
               }
               if(_goodstip3.tipData)
               {
                  _goodstip3.x = 0;
                  _goodstip1.x = _goodstip1.x + _goodstip1.width + 5;
               }
               break;
            case 1:
            case 3:
            case 4:
            case 6:
               if(_goodstip2.tipData)
               {
                  _goodstip2.x = 0;
                  if(_goodstip3.tipData)
                  {
                     _goodstip3.x = _goodstip2.x + _goodstip2.width + 5;
                     _goodstip1.x = _goodstip3.x + _goodstip3.width + 5;
                  }
                  else
                  {
                     _goodstip1.x = _goodstip2.x + _goodstip2.width + 5;
                  }
               }
               else if(_goodstip3.tipData)
               {
                  _goodstip3.x = 0;
                  _goodstip1.x = _goodstip3.x + _goodstip3.width + 5;
               }
               else
               {
                  _goodstip1.x = 0;
               }
         }
         _goodstip1.x = Math.round(_goodstip1.x);
         _goodstip1.y = Math.round(_goodstip1.y);
         _goodstip2.x = Math.round(_goodstip2.x);
         _goodstip2.y = Math.round(_goodstip2.y);
         _goodstip3.x = Math.round(_goodstip3.x);
         _goodstip3.y = Math.round(_goodstip3.y);
      }
      
      override public function set tipData(param1:Object) : void
      {
         var _loc2_:GoodsInfo = null;
         clean();
         _data = param1;
         if(!_data)
         {
            return;
         }
         _goodstip1.tipData = _data;
         addChild(_goodstip1);
         var _loc3_:Array = GoodsManager.instance.getHeroGoodsListBySonTypeAndId((_data as GoodsInfo).templateInfo.SonType,thane.id).getList();
         var _loc4_:Array = _loc3_.filter(GoodsCheck.filterGoodsForVice);
         _loc4_.sortOn("pos");
         if(_loc4_.length >= 2)
         {
            if(GoodsCheck.getEquipFighting(_loc4_[0] as GoodsInfo,(_loc4_[0] as GoodsInfo).templateInfo) >= GoodsCheck.getEquipFighting(_loc4_[1] as GoodsInfo,(_loc4_[1] as GoodsInfo).templateInfo))
            {
               _loc2_ = _loc4_[1] as GoodsInfo;
            }
            else
            {
               _loc2_ = _loc4_[0] as GoodsInfo;
            }
            _goodstip1.showEquipBg = true;
            _goodstip1.setHight(true);
            _goodstip2.tipData = _loc2_;
            addChild(_goodstip2);
            _goodstip1.x = 0;
            _goodstip2.x = _goodstip1.x + _goodstip1.width + 5;
         }
         else if(_loc4_.length >= 1)
         {
            _goodstip1.showEquipBg = true;
            _loc2_ = _loc4_[0] as GoodsInfo;
            _goodstip2.tipData = _loc2_;
            addChild(_goodstip2);
            _goodstip1.x = 0;
            _goodstip2.x = _goodstip1.x + _goodstip1.width + 5;
            _goodstip1.setHight(true);
         }
         else
         {
            _goodstip1.showEquipBg = false;
            _goodstip1.setHight(false);
            _goodstip1.x = 0;
         }
      }
      
      private function clean() : void
      {
         _goodstip1.tipData = null;
         _goodstip2.tipData = null;
         _goodstip3.tipData = null;
         if(_goodstip1.parent)
         {
            removeChild(_goodstip1);
         }
         if(_goodstip2.parent)
         {
            removeChild(_goodstip2);
         }
         if(_goodstip3.parent)
         {
            removeChild(_goodstip3);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         if(_goodstip1)
         {
            _goodstip1.dispose();
         }
         _goodstip1 = null;
         if(_goodstip2)
         {
            _goodstip2.dispose();
         }
         _goodstip2 = null;
         if(_goodstip3)
         {
            _goodstip3.dispose();
         }
         _goodstip3 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

