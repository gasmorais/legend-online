package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PathManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.community.BaseIconView;
   
   public class VIPCardTipView extends TaskTraceTipView
   {
      
      private var titleTxt:FilterFrameText;
      
      private var itemView:BaseIconView;
      
      private var txt:GradientText;
      
      private var btn:IconButton;
      
      public function VIPCardTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         var _loc3_:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("VIPCardTipView.back");
         addChild(_loc3_);
         var _loc2_:DisplayObject = ComponentFactory.Instance.creatCustomObject("VIPCardTipView.bg");
         addChild(_loc2_);
         titleTxt = ComponentFactory.Instance.creatComponentByStylename("VIPCardTipView.titleTxt");
         addChild(titleTxt);
         itemView = ComponentFactory.Instance.creatCustomObject("VIPCardTipView.itemView");
         addChild(itemView);
         txt = ComponentFactory.Instance.creatComponentByStylename("VIPCardTipView.vipCardTxt");
         addChild(txt);
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("VIPCardTipView.vipCardTipTxt");
         _loc1_.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.vipCommand02");
         addChild(_loc1_);
         btn = ComponentFactory.Instance.creatComponentByStylename("vip.useVipCardBtn");
         addChild(btn);
      }
      
      override protected function initEvent() : void
      {
         btn.addEventListener("click",__clickHandler);
      }
      
      override protected function removeEvent() : void
      {
         if(btn)
         {
            btn.removeEventListener("click",__clickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         useVipCard();
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
      
      override public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         if(data)
         {
            txt.text = data.goods.templateInfo.TemplateName;
            titleTxt.text = txt.text;
            itemView.icon = data.goods.templateInfo.iconPath;
         }
         titleTxt.text = txt.text = LanguageMgr.GetTranslation("tasktracetip.view.VIPCardTipView.titleTxt");
         itemView.icon = PathManager.resourcePath + "icon/item_VIPcard.png";
         LayerManager.Instance.addToLayer(this,1,true,true,2);
      }
      
      private function useVipCard() : void
      {
         data && SocketSendManager.instance.sendUseItem(data.goods.pos);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super._data = param1;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         if(btn)
         {
            btn.dispose();
         }
         btn = null;
         if(txt)
         {
            txt.dispose();
         }
         txt = null;
         if(_data)
         {
            _data.goods = null;
         }
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

