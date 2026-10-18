package monopoly.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.TempMsg;
   import flash.display.Sprite;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class MonopolyFinishRewardItemView extends Sprite implements Disposeable
   {
      
      private var _itemIconBg:Image;
      
      private var _itemIcon:BaseIconView;
      
      private var _itemIconImages:ScaleFrameImage;
      
      private var _itemCountTxt:FilterFrameText;
      
      private var _data:TempMsg;
      
      public function MonopolyFinishRewardItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _itemIconBg = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFinishRewardItemView.ItemIconBg");
         _itemIcon = ComponentFactory.Instance.creatCustomObject("monopoly.MonopolyFinishRewardItemView.ItemIcon");
         _itemIconImages = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFinishRewardItemView.ItemIconImages");
         _itemCountTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFinishRewardItemView.ItemCountTxt");
         addChild(_itemIconBg);
         addChild(_itemIcon);
         addChild(_itemCountTxt);
         _itemIcon.icon = _itemIconImages;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_itemIconBg);
         _itemIconBg = null;
         ObjectUtils.disposeObject(_itemIcon);
         _itemIcon = null;
         ObjectUtils.disposeObject(_itemCountTxt);
         _itemCountTxt = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function get iconFrame() : int
      {
         var _loc1_:int = 1;
         if(_data)
         {
            switch(_data.templateId)
            {
               case -500:
                  _loc1_ = 1;
                  break;
               case -100:
                  _loc1_ = 2;
                  break;
               case 208017:
                  _loc1_ = 3;
                  break;
               case 208020:
                  _loc1_ = 4;
                  break;
               case 208022:
                  _loc1_ = 5;
                  break;
               case 208023:
                  _loc1_ = 6;
                  break;
               case 208031:
                  _loc1_ = 7;
                  break;
               case 2060487:
                  _loc1_ = 8;
                  break;
               case 3040001:
                  _loc1_ = 9;
                  break;
               case 3270101:
                  _loc1_ = 10;
                  break;
               case 2240602:
                  _loc1_ = 11;
                  break;
               default:
                  _loc1_ = 1;
            }
         }
         return _loc1_;
      }
      
      public function refresh() : void
      {
         if(_data)
         {
            _itemIcon.icon = IconFactory.getGoodsIconByTID(_data.templateId);
            _itemCountTxt.text = _data.count.toString();
         }
      }
      
      public function set data(param1:TempMsg) : void
      {
         _data = param1;
         refresh();
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

