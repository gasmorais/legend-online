package wishpool
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.WishPoolManager;
   import mvc.module.wishpool.WishPoolInfoVO;
   import mvc.module.wishpool.WishPoolModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.NotificationManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class WishPoolItemView extends Component
   {
      
      private var _baseItemView:BaseItemView;
      
      private var _selectedImg:Image;
      
      private var _data:WishPoolInfoVO;
      
      public function WishPoolItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function set data(param1:WishPoolInfoVO) : void
      {
         var _loc2_:GoodsInfo = null;
         _data = param1;
         if(_data)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _data.tempalteId;
            _loc2_.count = _data.count;
            _baseItemView.data = _loc2_;
            _selectedImg.visible = false;
         }
         else
         {
            _baseItemView.data = null;
            _selectedImg.visible = false;
         }
      }
      
      private function initView() : void
      {
         _baseItemView = ComponentFactory.Instance.creatCustomObject("wishpool.itemView");
         _selectedImg = ComponentFactory.Instance.creatComponentByStylename("wishpool.selectedImg");
         addChild(_selectedImg);
         addChild(_baseItemView);
         _selectedImg.visible = false;
      }
      
      private function uninitView() : void
      {
         if(_baseItemView)
         {
            ObjectUtils.disposeObject(_baseItemView);
         }
         _baseItemView = null;
         if(_selectedImg)
         {
            ObjectUtils.disposeObject(_selectedImg);
         }
         _selectedImg = null;
      }
      
      private function initEvent() : void
      {
         this.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!model.isInActiveTime())
         {
            return;
         }
         if(model.selectedWishArray.indexOf(_data.key) != -1)
         {
            if(_selectedImg.visible)
            {
               _loc2_ = 0;
               while(_loc2_ < model.selectedWishArray.length)
               {
                  if(model.selectedWishArray[_loc2_] == _data.key)
                  {
                     model.selectedWishArray.splice(_loc2_,1);
                     break;
                  }
                  _loc2_++;
               }
               _selectedImg.visible = false;
            }
            else
            {
               if(model.selectedWishArray.length >= 3)
               {
                  _selectedImg.visible = false;
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("wishpool.wishPoolItemView.clickTips"));
                  return;
               }
               model.selectedWishArray.push(_data.key);
               _selectedImg.visible = true;
            }
         }
         else
         {
            if(model.selectedWishArray.length >= 3)
            {
               _selectedImg.visible = false;
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("wishpool.wishPoolItemView.clickTips"));
               return;
            }
            model.selectedWishArray.push(_data.key);
            _selectedImg.visible = true;
         }
         NotificationManager.instance.sendNotification("WISH_POOL_UPDATE_SELECTED");
      }
      
      private function get model() : WishPoolModel
      {
         return WishPoolManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

