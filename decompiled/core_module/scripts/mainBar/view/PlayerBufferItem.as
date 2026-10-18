package mainBar.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerBufferInfo;
   import yishi.manager.PlayerBufferManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   
   public class PlayerBufferItem extends Sprite implements Disposeable, IManualSize
   {
      
      private var _effect:MovieClip;
      
      private var _timeBack:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _time:FilterFrameText;
      
      private var _lastCount:FilterFrameText;
      
      private var _data:PlayerBufferInfo;
      
      private var _isPlaying:Boolean;
      
      public function PlayerBufferItem()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,36,50);
      }
      
      private function initView() : void
      {
         _timeBack = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.buffer.TimeBack");
         _icon = ComponentFactory.Instance.creatCustomObject("resourceBar.buffer.ItemIcon");
         _time = ComponentFactory.Instance.creatComponentByStylename("resourceBar.buffer.ItemTime");
         _lastCount = ComponentFactory.Instance.creatComponentByStylename("resourceBar.buffer.LastCount");
         _effect = ComponentFactory.Instance.creatCustomObject("resourceBar.buffer.Effect");
         addChild(_effect);
         _effect.gotoAndStop(1);
         _effect["content"].addChild(_icon);
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
         if(_data)
         {
            _data.removeEventListener("change",__changeHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(_data.bufferType == 0 || _data.bufferType == -1 || _data.bufferType == -2 || _data.bufferType == -3 || _data.bufferType == -4 || _data.bufferType == 20000 || _data.bufferType == -5 || _data.bufferType == 7 || _data.bufferType == 40005 || _data.bufferType == 40006 || _data.bufferType == 40007 || _data.bufferType == 8)
         {
            return;
         }
         SimpleAlertHelper.instance.data = [__alertBackHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("yishi.view.PlayerBufferItem.content");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            PlayerBufferManager.instance.removeBuffer(_data);
         }
      }
      
      private function __changeHandler(param1:Event) : void
      {
         var _loc2_:String = "";
         if(_data.leftTime >= 86400)
         {
            _loc2_ = int(_data.leftTime / 86400) + LanguageMgr.GetTranslation("public.day");
         }
         else if(_data.leftTime >= 3600)
         {
            _loc2_ = int(_data.leftTime / 3600) + LanguageMgr.GetTranslation("public.time.sigHour");
         }
         else if(_data.leftTime >= 60)
         {
            _loc2_ = int(_data.leftTime / 60) + LanguageMgr.GetTranslation("public.minute");
         }
         else
         {
            _loc2_ = int(_data.leftTime) + LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text1");
         }
         _time.text = _loc2_;
         if(_data.leftTime <= 10 && !_isPlaying)
         {
            _isPlaying = true;
            _effect.play();
         }
         else
         {
            _isPlaying = false;
            _effect.gotoAndStop(1);
         }
      }
      
      public function set data(param1:PlayerBufferInfo) : void
      {
         if(_data)
         {
            _data.removeEventListener("change",__changeHandler);
         }
         if(!param1)
         {
            return;
         }
         _data = param1;
         _data.addEventListener("change",__changeHandler);
         _icon.icon = IconFactory.getCommonIconPath(_data.icon);
         _icon.tipData = _data;
         var _loc2_:Number = _data.leftTime;
         if(_loc2_ > 0)
         {
            _effect["content"].addChild(_timeBack);
            _effect["content"].addChild(_time);
            __changeHandler(null);
         }
         if(_data.lastCount > 0)
         {
            _lastCount.text = _data.lastCount.toString();
            _effect["content"].addChild(_lastCount);
            _lastCount.setFrame(1);
         }
         if(_data.template && _data.template.hasOwnProperty("Types") && _data.template.Types == 4)
         {
            _effect["content"].addChild(_lastCount);
            _lastCount.text = _data.template.Grades;
            _lastCount.setFrame(2);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         ObjectUtils.disposeObject(_lastCount);
         _lastCount = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         _data = null;
      }
   }
}

