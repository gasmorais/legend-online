package luckyexchange
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class LuckyexchangeBagItem extends Component
   {
      
      private var _title:FilterFrameText;
      
      private var _bgContainer:Component;
      
      private var _rewardList:SimpleTileList;
      
      private var _effectContainer:Component;
      
      private var _index:int;
      
      public function LuckyexchangeBagItem(param1:int)
      {
         _index = param1;
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.bagItem.title");
         _rewardList = ComponentFactory.Instance.creatCustomObject("luckyexchange.rewardTileList");
         _bgContainer = ComponentFactory.Instance.creatCustomObject("luckyexchange.itemBgComponent");
         _effectContainer = ComponentFactory.Instance.creatCustomObject("luckyexchange.effectComponent");
         addChild(_title);
         addChild(_bgContainer);
         addChild(_rewardList);
         addChild(_effectContainer);
         _rewardList.column = 9;
         _bgContainer.x = _rewardList.x;
         _bgContainer.y = _rewardList.y;
         _effectContainer.x = _rewardList.x;
         _effectContainer.y = _rewardList.y;
         _effectContainer.mouseChildren = _effectContainer.mouseEnabled = false;
      }
      
      public function set multi(param1:Boolean) : void
      {
         var _loc2_:String = param1 ? LanguageMgr.GetTranslation("luckyexchange.LuckyexchangeBagItem.titleMultiTxt") : "";
         switch(_index)
         {
            case 0:
               _title.text = "";
               _bgContainer.y = 4;
               _rewardList.y = 4;
               _effectContainer.y = 4;
               break;
            case 1:
               _title.text = _loc2_ + LanguageMgr.GetTranslation("luckyexchange.LuckyexchangeBagItem.titleTxt1");
               break;
            case 2:
               _title.text = _loc2_ + LanguageMgr.GetTranslation("luckyexchange.LuckyexchangeBagItem.titleTxt2");
               break;
            case 3:
               _title.text = _loc2_ + LanguageMgr.GetTranslation("luckyexchange.LuckyexchangeBagItem.titleTxt3");
               break;
            case 4:
               _title.text = _loc2_ + LanguageMgr.GetTranslation("luckyexchange.LuckyexchangeBagItem.titleTxt4");
         }
      }
      
      public function set data(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Bitmap = null;
         var _loc2_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc6_:MovieImage = null;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.luckyexchange.itemBg");
            _bgContainer.addChild(_loc3_);
            _loc2_ = ComponentFactory.Instance.creatCustomObject("luckyexchange.iconRewardView");
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = param1[_loc4_].itemId;
            _loc5_.count = param1[_loc4_].itemCount;
            _loc5_.showCount = true;
            _loc2_.data = _loc5_;
            _rewardList.addChild(_loc2_);
            if(_index == 0)
            {
               _loc6_ = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.iconEffect");
               _loc6_.mouseEnabled = _loc6_.mouseChildren = false;
               _effectContainer.addChild(_loc6_);
               _loc6_.x = _loc2_.x + 23;
               _loc6_.y = _loc2_.y + 23;
            }
            _loc3_.x = _loc2_.x - 2;
            _loc3_.y = _loc2_.y - 2;
            _loc4_++;
         }
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_bgContainer);
         _bgContainer = null;
         ObjectUtils.disposeObject(_rewardList);
         _rewardList = null;
         ObjectUtils.disposeObject(_effectContainer);
         _effectContainer = null;
         super.dispose();
      }
   }
}

