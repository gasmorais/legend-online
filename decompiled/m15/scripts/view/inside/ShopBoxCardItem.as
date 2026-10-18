package view.inside
{
   import bag.helper.GoodsCheck;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class ShopBoxCardItem extends Component
   {
      
      private var _mc:MovieClip;
      
      private var _index:int;
      
      private var _data:GoodsInfo;
      
      private var _playIng:Boolean = false;
      
      private var _playOver:Boolean = false;
      
      private var _clickCallBack:Function;
      
      private var _iconEffect:MovieClip;
      
      private var _lightEffect:MovieClip;
      
      public function ShopBoxCardItem(param1:int)
      {
         super();
         _index = param1;
         initView();
      }
      
      private function initView() : void
      {
         _mc = ComponentFactory.Instance.creatCustomObject("asset.shopBoxCardItem.itemEffect");
         _iconEffect = ComponentFactory.Instance.creatCustomObject("asset.shopBoxCardItem.iconEffect");
         _lightEffect = ComponentFactory.Instance.creatCustomObject("asset.shopBoxCardItem.lightEffect");
         addChild(_lightEffect);
         addChild(_mc);
         addChild(_iconEffect);
         _mc.gotoAndStop(1);
         _lightEffect.gotoAndStop(1);
         _iconEffect.gotoAndStop(1);
         _lightEffect.visible = false;
         _iconEffect.visible = false;
         _iconEffect.mouseChildren = _iconEffect.mouseEnabled = false;
         _lightEffect.mouseChildren = _lightEffect.mouseEnabled = false;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         _mc.addFrameScript(4,updateGoods);
         _mc.addFrameScript(5,updateEffect);
         if(isFashionOrMount)
         {
            _iconEffect.visible = true;
            _iconEffect.gotoAndPlay(1);
         }
      }
      
      private function updateGoods() : void
      {
         var _loc1_:BaseItemView = ComponentFactory.Instance.creatCustomObject("ExchangeBoxFrame.getItem1");
         _loc1_.data = _data;
         _mc["showGood"]["goodItem"].removeChildAt(0);
         _mc["showGood"]["goodItem"].addChild(_loc1_);
      }
      
      private function updateEffect() : void
      {
         if(isFashionOrMount)
         {
            _lightEffect.visible = true;
            _lightEffect.gotoAndPlay(1);
         }
      }
      
      private function get isFashionOrMount() : Boolean
      {
         if(!_data)
         {
            return false;
         }
         return GoodsCheck.isFashion(_data.templateInfo) || _data.templateInfo.SonType == 218;
      }
      
      public function play(param1:Function = null) : void
      {
         var callBack:Function = param1;
         if(isFashionOrMount)
         {
            if(callBack != null)
            {
               callBack(_index + 1);
               return;
            }
         }
         _mc.gotoAndPlay(1);
         _playIng = true;
         if(callBack != null)
         {
            _mc.addFrameScript(_mc.totalFrames - 1,function():void
            {
               _mc.stop();
               _playIng = false;
               _playOver = true;
               callBack(_index + 1);
            });
         }
      }
      
      public function allPlay() : void
      {
         if(!_playIng && !_playOver)
         {
            _mc.gotoAndPlay(1);
            _iconEffect.visible = false;
            _iconEffect.gotoAndStop(1);
            _playIng = true;
            _mc.addFrameScript(_mc.totalFrames - 1,function():void
            {
               _mc.stop();
               _playIng = false;
               _playOver = true;
               setClick(null);
            });
         }
      }
      
      public function setClick(param1:Function) : void
      {
         if(!isFashionOrMount)
         {
            return;
         }
         _clickCallBack = param1;
         _mc.buttonMode = true;
         initEvent();
      }
      
      private function initEvent() : void
      {
         _mc.addEventListener("click",__onClickHandler);
      }
      
      private function removeEvent() : void
      {
         _mc.removeEventListener("click",__onClickHandler);
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(!_playIng && !_playOver)
         {
            _mc.gotoAndPlay(1);
            _iconEffect.visible = false;
            _iconEffect.gotoAndStop(1);
            _playIng = true;
            _mc.addFrameScript(_mc.totalFrames - 1,function():void
            {
               _mc.stop();
               _playIng = false;
               _playOver = true;
               if(_clickCallBack != null)
               {
                  _clickCallBack();
               }
               showAvatarFrame();
            });
         }
         else if(_playOver)
         {
            showAvatarFrame();
         }
      }
      
      public function get playOver() : Boolean
      {
         return _playOver;
      }
      
      public function showAvatarFrame() : void
      {
         var _loc1_:ShopAvatarFrame = ComponentFactory.Instance.creatComponentByStylename("view.inside.ShopAvatarFrame",[_data]);
         _loc1_.show();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         ObjectUtils.disposeViolentMc(_iconEffect);
         _iconEffect = null;
         ObjectUtils.disposeViolentMc(_lightEffect);
         _lightEffect = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

