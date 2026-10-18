package secretadventure.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.secret.SecretAdventureModel;
   import yishi.datas.templates.SecretMapLevelTemplate;
   import yishi.filter.UIFilter;
   import yishi.manager.SecretAdventerManager;
   
   public class SecretAdventureItem extends Component
   {
      
      private var _wait:Bitmap;
      
      private var _itemSelected:Bitmap;
      
      private var _title:SecretAdTitle;
      
      private var _bgImg:ScaleFrameImage;
      
      private var _itemLock:Bitmap;
      
      private var _isLock:Boolean;
      
      private var _temp:SecretMapLevelTemplate;
      
      private var _gray:Array;
      
      private var _isSelect:Boolean;
      
      private var _tipStr:String;
      
      public function SecretAdventureItem()
      {
         super();
         initView();
      }
      
      public function set isSelect(param1:Boolean) : void
      {
         _isSelect = param1;
         _itemSelected.visible = _isSelect;
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         _isLock = param1;
         if(_itemLock)
         {
            _itemLock.visible = _isLock;
         }
         if(_isLock)
         {
            this.filters = _gray;
            this.tipData = _tipStr;
         }
         else
         {
            this.filters = null;
            this.tipData = null;
         }
      }
      
      private function initView() : void
      {
         _bgImg = ComponentFactory.Instance.creatComponentByStylename("ui.secretadProgress.itemBg");
         _itemSelected = ComponentFactory.Instance.creatBitmap("asset.secretad.itemSelected");
         _title = ComponentFactory.Instance.creatCustomObject("ui.secretadventure.title");
         _itemLock = ComponentFactory.Instance.creatBitmap("asset.secretad.itemLock");
         addChild(_bgImg);
         addChild(_title);
         addChild(_itemLock);
         addChild(_itemSelected);
         _itemSelected.visible = false;
         _gray = [UIFilter.getGrayFilter()];
      }
      
      private function initEvent() : void
      {
         this.addEventListener("click",itemClickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",itemClickHandler);
      }
      
      private function itemClickHandler(param1:MouseEvent) : void
      {
         model.selectItem = this;
      }
      
      private function get model() : SecretAdventureModel
      {
         return SecretAdventerManager.Instance.model;
      }
      
      public function set temp(param1:SecretMapLevelTemplate) : void
      {
         _temp = param1;
         if(_temp)
         {
            if(_tipStr == null)
            {
               _tipStr = LanguageMgr.GetTranslation("secret.lock.areaTip",_temp.Description);
            }
            _bgImg.setFrame(_temp.Type);
            _title.loadTitle(_temp.Type);
            initEvent();
         }
         else
         {
            if(!_wait)
            {
               _bgImg.setFrame(5);
               _wait = ComponentFactory.Instance.creatBitmap("asset.secretad.wait");
               addChildAt(_wait,0);
               _title.preNull();
            }
            _itemLock.visible = false;
         }
      }
      
      public function get temp() : SecretMapLevelTemplate
      {
         return _temp;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_wait);
         _wait = null;
         ObjectUtils.disposeObject(_itemSelected);
         _itemSelected = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_itemLock);
         _itemLock = null;
         ObjectUtils.disposeObject(_bgImg);
         _bgImg = null;
         super.dispose();
         _temp = null;
         _gray = null;
      }
   }
}

