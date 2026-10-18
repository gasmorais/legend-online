package consortia.view.fb.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.GuildFbController;
   import mvc.module.guildfb.GuildFBNode;
   import yishi.manager.FrameControllerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class GuildFBNodeItem extends Sprite
   {
      
      private var _nodeImg:ScaleFrameImage;
      
      private var _bit8:Bitmap;
      
      private var _nodeIdxTxt:FilterFrameText;
      
      private var _data:GuildFBNode;
      
      public function GuildFBNodeItem()
      {
         super();
         initView();
         initEvent();
         buttonMode = true;
      }
      
      public function get data() : GuildFBNode
      {
         return _data;
      }
      
      public function set data(param1:GuildFBNode) : void
      {
         _data = param1;
         if(param1 == null)
         {
            _bit8.visible = false;
            _nodeImg.visible = false;
            _nodeIdxTxt.setFrame(2);
         }
         else
         {
            _nodeImg.visible = true;
            _nodeIdxTxt.setFrame(1);
            _bit8.visible = _data.rewardState == 1;
            if(_data.rewardState == 3)
            {
               _nodeImg.setFrame(2);
            }
            else
            {
               _nodeImg.setFrame(1);
            }
         }
      }
      
      public function refreshIdx(param1:int, param2:int) : void
      {
         _nodeIdxTxt.text = param1 + "-" + param2;
      }
      
      private function initView() : void
      {
         _nodeImg = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.nodeImg");
         _bit8 = ComponentFactory.Instance.creatBitmap("asset.guild.nodeFlg");
         _nodeIdxTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.nodeIdxTxt");
         addChild(_nodeImg);
         addChild(_bit8);
         addChild(_nodeIdxTxt);
         _nodeImg.setFrame(1);
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
         if(_data != null)
         {
            if(_data.rewardState == 1)
            {
               control.requestOp(3,_data.nodeID);
            }
            else
            {
               FrameControllerManager.instance.openControllerByInfo("guildfb",1,_data);
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("guildfb.fight.openTip"));
         }
      }
      
      private function get control() : GuildFbController
      {
         return FrameControllerManager.instance.guildFbController;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_nodeImg);
         _nodeImg = null;
         ObjectUtils.disposeObject(_bit8);
         _bit8 = null;
         ObjectUtils.disposeObject(_nodeIdxTxt);
         _nodeIdxTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

