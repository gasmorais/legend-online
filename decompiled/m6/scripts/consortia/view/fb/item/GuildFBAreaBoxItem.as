package consortia.view.fb.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.GuildFbController;
   import mvc.module.guildfb.GuildFBAreaNode;
   import yishi.manager.FrameControllerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class GuildFBAreaBoxItem extends Component
   {
      
      private var _bit5:Bitmap;
      
      private var _botoomBox:ScaleFrameImage;
      
      private var _bit6:Bitmap;
      
      private var _data:GuildFBAreaNode;
      
      private var _tipParam:Array;
      
      public function GuildFBAreaBoxItem()
      {
         super();
         initView();
         initEvent();
         buttonMode = true;
      }
      
      public function get data() : GuildFBAreaNode
      {
         return _data;
      }
      
      public function set data(param1:GuildFBAreaNode) : void
      {
         _data = param1;
         if(_data == null)
         {
            _botoomBox.setFrame(1);
            _bit6.visible = false;
         }
         else
         {
            _bit6.visible = false;
            _botoomBox.setFrame(_data.rewardState + 1);
            if(_data.rewardState == 2)
            {
               _bit6.visible = true;
               tipData = null;
            }
         }
      }
      
      public function setTipParam(param1:Array) : void
      {
         _tipParam = param1;
         tipData = _tipParam;
      }
      
      private function initView() : void
      {
         _bit5 = ComponentFactory.Instance.creatBitmap("asset.guild.botoom.boxBack");
         _botoomBox = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.botoomBox");
         _bit6 = ComponentFactory.Instance.creatBitmap("asset.guild.botoom.getFlg");
         addChild(_bit5);
         addChild(_botoomBox);
         addChild(_bit6);
      }
      
      private function initEvent() : void
      {
         addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(_data == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("guildfb.getAreaRewardTip"));
            return;
         }
         if(_data.rewardState == 1)
         {
            control.requestOp(5,_data.areaId,_data.diff);
         }
         FrameControllerManager.instance.openControllerByInfo("guildfb",2,_data);
      }
      
      private function get control() : GuildFbController
      {
         return FrameControllerManager.instance.guildFbController;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bit5);
         _bit5 = null;
         ObjectUtils.disposeObject(_botoomBox);
         _botoomBox = null;
         ObjectUtils.disposeObject(_bit6);
         _bit6 = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
         _tipParam = null;
      }
   }
}

