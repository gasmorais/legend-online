package consortia.view.fb
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.guildfb.GuildFBNode;
   import mvc.module.guildfb.GuildFBPlayerInfo;
   import utils.LogicUtils;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class GuildFBFightInfoFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _desText:FilterFrameText;
      
      private var _panel:ScrollPanel;
      
      private var _vbox:VBox;
      
      private var _iconList:Vector.<BaseIconView>;
      
      private var MAX:int = 8;
      
      private var _parent:Frame;
      
      public function GuildFBFightInfoFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:BaseIconView = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.fightInfoInnerBack");
         _desText = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.fightInfoDes");
         _panel = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.scrollPanel");
         _vbox = ComponentFactory.Instance.creatCustomObject("ui.guildfb.scrollVbox");
         addToContent(_bg);
         addToContent(_desText);
         addToContent(_panel);
         _panel.setView(_vbox);
         _panel.invalidateViewport();
         var _loc3_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("consortia_pve_fight_count");
         if(_loc3_ != null)
         {
            MAX = int(_loc3_.ConfigValue);
         }
         _iconList = new Vector.<BaseIconView>();
         _loc2_ = 0;
         while(_loc2_ < MAX)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ui.guildfb.fight.playerInfoIcon");
            _iconList[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      private function refreshView(param1:GuildFBNode) : void
      {
         var _loc2_:GuildFBPlayerInfo = null;
         var _loc4_:int = 0;
         ObjectUtils.removeChildAllChildrenFromStage(_vbox);
         _vbox.beginChanges();
         var _loc5_:Array = param1.playerList;
         var _loc3_:int = int(_loc5_.length);
         if(_loc3_ > MAX)
         {
            _loc3_ = MAX;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _loc5_[_loc4_];
            _iconList[_loc4_].icon = IconFactory.getPlayerIcon(_loc2_.headId,"head");
            _iconList[_loc4_].tipData = LanguageMgr.GetTranslation("guildfb.playinfo.tip",_loc2_.nickName,_loc2_.fightPower);
            _vbox.addChild(_iconList[_loc4_]);
            _loc4_++;
         }
         _vbox.commitChanges();
         _panel.invalidateViewport();
         _desText.text = LanguageMgr.GetTranslation("guildfb.fightNode.attackPlayerNum",_loc3_);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         MsgMan.addObserver("GuildFBModel.fightInfo",this,refreshInfosHandler);
         StageReferance.stage.addEventListener("resize",resizeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         MsgMan.removeObserver("GuildFBModel.fightInfo",this,refreshInfosHandler);
         StageReferance.stage.removeEventListener("resize",resizeHandler);
      }
      
      private function resizeHandler(param1:Event) : void
      {
         show(_parent);
      }
      
      private function refreshInfosHandler(param1:String, param2:Object) : void
      {
         var _loc3_:GuildFBNode = param2 as GuildFBNode;
         refreshView(_loc3_);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:Frame) : void
      {
         _parent = param1;
         LayerManager.Instance.addTolayerRelated(param1,this,3,true,false);
         this.x -= 60;
         this.y += 35;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_desText);
         _desText = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         LogicUtils.disposeDisplayCollection(_iconList);
         _iconList = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         _parent = null;
      }
   }
}

