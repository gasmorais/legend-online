package cell.view.storebag
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.DoubleClickManager;
   import manager.LanguageMgr;
   import mvc.module.store.StoreModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.ResourceManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class StoreJewelCell extends StoreIntensifyCell
   {
      
      private var _jewelcombox:TextButton;
      
      public var notOpen:Boolean;
      
      private var _index:int;
      
      public var isViceEquip:Boolean;
      
      private var _mediatorKey:String;
      
      private var _lock:Boolean;
      
      public function StoreJewelCell(param1:int)
      {
         super();
         _index = param1;
         initView();
      }
      
      private function initView() : void
      {
         _jewelcombox = ComponentFactory.Instance.creatComponentByStylename("core.MoveButton");
         _jewelcombox.text = LanguageMgr.GetTranslation("cell.view.storebag.jewelcombox");
         _jewelcombox.y = 69;
         _jewelcombox.width = 70;
         addChild(_jewelcombox);
         _jewelcombox.enable = false;
      }
      
      override protected function registerMediator() : void
      {
         addEventListener("interactive_click",__clickHandler);
         addEventListener("interactive_double_click",__onDoubleClick);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      private function __clickHandler(param1:InteractiveEvent) : void
      {
         if(notOpen && _jewelcombox.visible)
         {
            FrameControllerManager.instance.storeController.openHole(pos);
         }
      }
      
      private function __onDoubleClick(param1:InteractiveEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(model.selectedPanel == "STORE_PANEL_MOUNT" && data && (data.templateInfo.SonType == 205 || data.templateInfo.SonType == 228))
         {
            SimpleAlertHelper.instance.data = [removeJewelResponse];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("cell.view.storebag.StoreJewelCell.content",data.templateInfo.Property3);
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
         }
      }
      
      private function removeJewelResponse(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         if(param1)
         {
            if(data.templateInfo.Property3 > ResourceManager.instance.gold.count)
            {
               _loc3_ = LanguageMgr.GetTranslation("public.gold");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            SocketSendManager.instance.sendPunch(pos,false);
         }
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         var _loc2_:GoodsInfo = null;
         if(param1)
         {
            _jewelcombox.visible = _jewelcombox.enable = false;
            notOpen = false;
            isViceEquip = param1.isViceEquip;
            if(param1["join" + _index] > 0)
            {
               ScaleFrameImage(_back).setFrame(2);
               _loc2_ = new GoodsInfo();
               _loc2_.templateId = param1["join" + _index];
               super.data = _loc2_;
               return;
            }
            if(param1["join" + _index] == 0)
            {
               ScaleFrameImage(_back).setFrame(2);
               super.data = null;
               return;
            }
            if(param1.isViceEquip)
            {
               if(param1.templateInfo.Profile < 4)
               {
                  if(param1["join" + _index] == -1)
                  {
                     notOpen = true;
                     _jewelcombox.visible = _jewelcombox.enable = notOpen;
                     if(_index == 4)
                     {
                        _jewelcombox.visible = false;
                        super.data = null;
                        ScaleFrameImage(_back).setFrame(3);
                     }
                     else
                     {
                        super.data = null;
                        ScaleFrameImage(_back).setFrame(1);
                     }
                  }
                  return;
               }
               if(param1["join" + _index] == -1)
               {
                  notOpen = true;
                  if(_index == 4)
                  {
                     super.data = null;
                     ScaleFrameImage(_back).setFrame(3);
                  }
                  else
                  {
                     super.data = null;
                     ScaleFrameImage(_back).setFrame(1);
                  }
                  _jewelcombox.visible = _jewelcombox.enable = param1["join" + _index] == -1;
                  return;
               }
            }
            else
            {
               if(param1.templateInfo.Profile < 5)
               {
                  if(param1["join" + _index] == -1)
                  {
                     notOpen = true;
                     _jewelcombox.visible = _jewelcombox.enable = notOpen;
                     if(_index == 4)
                     {
                        _jewelcombox.visible = false;
                        super.data = null;
                        ScaleFrameImage(_back).setFrame(3);
                     }
                     else
                     {
                        super.data = null;
                        ScaleFrameImage(_back).setFrame(1);
                     }
                  }
                  return;
               }
               if(param1["join" + _index] == -1)
               {
                  notOpen = true;
                  if(_index == 4)
                  {
                     super.data = null;
                     ScaleFrameImage(_back).setFrame(3);
                  }
                  else
                  {
                     super.data = null;
                     ScaleFrameImage(_back).setFrame(1);
                  }
                  _jewelcombox.visible = _jewelcombox.enable = param1["join" + _index] == -1;
                  return;
               }
            }
         }
         super.data = null;
         ScaleFrameImage(_back).setFrame(1);
         _jewelcombox.visible = _jewelcombox.enable = false;
      }
      
      private function get model() : StoreModel
      {
         return FrameControllerManager.instance.storeController.model;
      }
      
      override public function dispose() : void
      {
         removeEventListener("interactive_click",__clickHandler);
         removeEventListener("interactive_double_click",__onDoubleClick);
         super.dispose();
      }
      
      public function get lock() : Boolean
      {
         return _lock;
      }
      
      public function set lock(param1:Boolean) : void
      {
         _lock = param1;
         this.mouseChildren = this.mouseEnabled = !_lock;
      }
   }
}

