package marry.view
{
   import bag.helper.BagHelper;
   import chat.view.ChatBugleViewII;
   import chat.view.ChatInputViewII;
   import chat.view.ChatOutputViewII;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dialog.DialogWordView;
   import dialog.data.DialogMessageInfo;
   import dialog.view.DialogRoleImage;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mainBar.ChatBar;
   import mainBar.FullBar;
   import mainBar.SmallMapBar;
   import mainBar.TipsBar;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import managers.TaskTraceTipManager;
   import map.campaign.CampaignManager;
   import map.space.SpaceManager;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.resourcebar.ResourcesBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class MarryFlowerView extends Sprite implements Disposeable, IEnterFrame
   {
      
      private var _headWide:int;
      
      private var _flowerBg:Scale9CornerImage;
      
      private var _bottomBg:ScaleBitmapImage;
      
      private var _whiteBg:Shape;
      
      private var _leftImage:DialogRoleImage;
      
      private var _rightImage1:DialogRoleImage;
      
      private var _rightImage2:DialogRoleImage;
      
      private var _dialogWordView:DialogWordView;
      
      private var angelImage1:Bitmap;
      
      private var angelImage2:Bitmap;
      
      private var _isDie:Boolean;
      
      private var _count:int;
      
      private var _bugleView:ChatBugleViewII;
      
      private var _input:ChatInputViewII;
      
      private var _output:ChatOutputViewII;
      
      private var _outputRect:Rectangle;
      
      private var _state:int = -1;
      
      private var _outputBarShowFlag:Boolean;
      
      public function MarryFlowerView()
      {
         super();
         _isDie = false;
         begin();
         initView();
         initChatBar();
         initEvent();
      }
      
      private function initChatBar() : void
      {
         if(!ChatBar.instance.isLoaded)
         {
            ChatBar.instance.show(initChatBar);
            return;
         }
         ChatBar.instance.chatOutPutView.showMinView(true);
         ChatBar.instance.chatOutPutView.cleanBtn.alpha = 0;
         ChatBar.instance.upBtn.alpha = 0;
         ChatBar.instance.downBtn.alpha = 0;
         ChatBar.instance.buttonBox.alpha = 0;
         ChatBar.instance.buttonBox.x = 24;
         ChatBar.instance.chatOutPutView.back.alpha = 0;
         ChatBar.instance.chatOutPutView.chatList.vScrollbar.alpha = 0;
         ChatBar.instance.chatOutPutView.toBottomBtn.alpha = 0;
         _bugleView = ChatBar.instance.chatBugleView;
         _input = ChatBar.instance.chatInputView;
         _output = ChatBar.instance.chatOutPutView;
         _input.currentInChannel = 6;
         _output.currentOutChannel = 6;
         addChild(_bugleView);
         addChild(_input);
         addChild(_output);
         resizeChatBar();
      }
      
      private function initView() : void
      {
         _whiteBg = new Shape();
         _whiteBg.graphics.beginFill(0,0);
         _whiteBg.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         _whiteBg.graphics.endFill();
         addChild(_whiteBg);
         _flowerBg = ComponentFactory.Instance.creatComponentByStylename("marry.WeddingBackgoundBase");
         addChild(_flowerBg);
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("marry.weddingDialogBg");
         addChild(_bottomBg);
         angelImage1 = ComponentFactory.Instance.creatBitmap("asset.wedding.angel01");
         angelImage2 = ComponentFactory.Instance.creatBitmap("asset.wedding.angel02");
         addChild(angelImage1);
         addChild(angelImage2);
         _leftImage = new DialogRoleImage();
         _leftImage.alpha = 0;
         addChild(_leftImage);
         _leftImage.loadImagesByRoleId([35]);
         _rightImage1 = new DialogRoleImage();
         _rightImage1.scaleX = -1;
         _rightImage1.alpha = 0;
         addChild(_rightImage1);
         _rightImage1.loadImagesByRoleId([myJob]);
         _rightImage2 = new DialogRoleImage();
         _rightImage2.scaleX = -1;
         _rightImage2.alpha = 0;
         addChild(_rightImage2);
         _dialogWordView = new DialogWordView();
         addChild(_dialogWordView);
         if(_bugleView)
         {
            addChild(_bugleView);
         }
         if(_input)
         {
            addChild(_input);
         }
         if(_output)
         {
            addChild(_output);
         }
         __onResizeHandler();
         _count = 0;
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__onResizeHandler);
         EnterFrameManager.instance.registeEnterFrame(this);
         StageReferance.stage.addEventListener("mouseMove",onMouseMove);
         MsgMan.addObserver("yishi.datas.consant.BIG_BUGLE_EVENT",this,updateVbox);
      }
      
      private function updateVbox(param1:String, param2:Object) : void
      {
         resizeChatBar();
      }
      
      public function enterFrame() : void
      {
         _count = _count + 1;
         if(WorldBossHelper.checkWedding(CampaignManager.instance.mapId))
         {
            if(MarryManager.instance.model.selfMarryInfo.speTemplateId == 0 && MarryManager.instance.model.weddingInfo.property9 == 1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("marry.view.MarryFlowerView.toHideMarryCar"));
               dispose();
               SoundManager.instance.playMusic("bgm_wedding");
            }
            else if(MarryManager.instance.model.selfMarryInfo.speTemplateId == 0 && MarryManager.instance.model.weddingInfo.property9 == 2)
            {
               dispose();
               SoundManager.instance.playMusic("bgm_wedding");
            }
            else if(MarryManager.instance.model.selfMarryInfo.speTemplateId == 0 && MarryManager.instance.model.weddingInfo.property9 == 3)
            {
               dispose();
               SoundManager.instance.playMusic("bgm_wedding");
            }
            else if(_count > 1500)
            {
               dispose();
               SoundManager.instance.playMusic("bgm_wedding");
            }
         }
         else if(SpaceManager.instance.exit == false)
         {
            if(!MarryManager.instance.model.lockScreen)
            {
               dispose();
            }
            else if(_count > 6000)
            {
               dispose();
            }
         }
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         if(!ChatBar.instance.isLoaded)
         {
            return;
         }
         var _loc2_:Array = [ChatBar.instance.buttonBox,ChatBar.instance.chatOutPutView.cleanBtn,ChatBar.instance.chatOutPutView.back,ChatBar.instance.chatOutPutView.chatList.vScrollbar,ChatBar.instance.chatOutPutView.toBottomBtn];
         var _loc3_:Boolean = _outputRect.contains(this.mouseX,this.mouseY);
         if(_loc3_)
         {
            if(!_outputBarShowFlag)
            {
               TweenMax.allTo(_loc2_,0.3,{
                  "alpha":1,
                  "onComplete":stop
               });
               _outputBarShowFlag = true;
            }
         }
         else if(_outputBarShowFlag)
         {
            TweenMax.allTo(_loc2_,0.3,{
               "alpha":0,
               "onComplete":stop
            });
            _outputBarShowFlag = false;
         }
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__onResizeHandler);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         StageReferance.stage.removeEventListener("mouseMove",onMouseMove);
         MsgMan.removeObserver("yishi.datas.consant.BIG_BUGLE_EVENT",this,updateVbox);
      }
      
      public function showMessage(param1:DialogMessageInfo) : void
      {
         if(_isDie || param1 == null)
         {
            return;
         }
         _dialogWordView.setSentence(param1.txt,null,param1.roleName);
         swapHeadImg(param1);
      }
      
      private function swapHeadImg(param1:DialogMessageInfo) : void
      {
         var _loc2_:DialogRoleImage = null;
         if(!param1)
         {
            return;
         }
         if(param1.direction == 0)
         {
            _loc2_ = _leftImage;
            _leftImage.visible = true;
            _rightImage1.visible = false;
            _rightImage2.visible = false;
         }
         else
         {
            _leftImage.visible = false;
            if(param1.roleId == myJob)
            {
               _loc2_ = _rightImage1;
               _rightImage1.visible = true;
               _rightImage2.visible = false;
            }
            else
            {
               _loc2_ = _rightImage2;
               _rightImage1.visible = false;
               _rightImage2.visible = true;
            }
         }
         TweenMax.to(_loc2_,0.5,{
            "alpha":1,
            "colorTransform":{
               "tint":0,
               "tintAmount":0.01
            }
         });
         _loc2_.swapToRoleById(param1.roleId);
      }
      
      public function setRoles(param1:int) : void
      {
         if(param1 != 35 && param1 != myJob)
         {
            _rightImage2.loadImagesByRoleId([param1]);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,0);
      }
      
      private function get myJob() : int
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.job;
      }
      
      private function __onResizeHandler(param1:Event = null) : void
      {
         var _loc4_:int = 0;
         if(_isDie)
         {
            return;
         }
         var _loc2_:Number = StageReferance.stageWidth;
         var _loc3_:Number = StageReferance.stageHeight;
         this.scrollRect = new Rectangle(0,0,_loc2_,_loc3_);
         _whiteBg.width = _loc2_;
         _whiteBg.height = _loc3_;
         _flowerBg.width = _loc2_;
         _flowerBg.height = _loc3_;
         angelImage2.x = _loc2_ - angelImage2.width;
         angelImage2.y = _loc3_ - angelImage2.height;
         if(SpaceManager.instance.exit == false)
         {
            _bottomBg.visible = false;
            _leftImage.visible = false;
            _rightImage1.visible = false;
            _rightImage2.visible = false;
            _dialogWordView.visible = false;
         }
         else
         {
            _loc4_ = CampaignManager.instance.mapId;
            if(WorldBossHelper.checkWedding(_loc4_))
            {
               _bottomBg.width = _loc2_;
               _bottomBg.y = _loc3_ - _bottomBg.displayHeight + 26;
               _leftImage.x = -70;
               _leftImage.y = _bottomBg.y - 165;
               _rightImage1.x = _loc2_ + 10;
               _rightImage1.y = _leftImage.y;
               _rightImage2.x = _loc2_ + 10;
               _rightImage2.y = _leftImage.y;
               refreshHeadWide();
               _dialogWordView.y = _bottomBg.y + 5;
               _dialogWordView.refreshSize(_loc2_ - _headWide * 2 + 20);
               _dialogWordView.x = _headWide;
            }
         }
         resizeChatBar();
      }
      
      private function resizeChatBar() : void
      {
         if(_output == null || _bugleView == null || _input == null)
         {
            return;
         }
         var _loc1_:Number = StageReferance.stageWidth;
         var _loc2_:Number = StageReferance.stageHeight;
         _output.x = 170;
         _output.y = _loc2_ - _output.viewRectangle.height - 150;
         _bugleView.x = _output.x;
         _bugleView.y = _output.y - _bugleView.viewRectangle.height;
         _input.x = 190 + _output.viewRectangle.width;
         _input.y = _loc2_ - 190;
         if(SpaceManager.instance.exit == false)
         {
            _output.x -= 115;
            _output.y += 75;
            _bugleView.x -= 115;
            _bugleView.y += 75;
            _input.x -= 115;
         }
         if(_outputRect == null)
         {
            _outputRect = new Rectangle(_output.x,_output.y,ChatBar.instance.chatOutPutView.back.width,ChatBar.instance.chatOutPutView.back.height);
         }
         _outputRect.x = _output.x;
         _outputRect.y = _output.y;
      }
      
      private function refreshHeadWide() : void
      {
         if(StageReferance.stageWidth < 1000)
         {
            _headWide = 300;
         }
         else if(StageReferance.stageWidth > 1500)
         {
            _headWide = 400;
         }
         else
         {
            _headWide = (StageReferance.stageWidth - 1000) / 500 * 100 + 300;
         }
      }
      
      private function begin() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         MarryManager.instance.model.lockScreen = true;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_FREEDOMTEAMLIST",true));
         FullBar.instance.hide();
         MainToolBar.instance.hide();
         TopToolsBar.instance.hide();
         TipsBar.instance.hide();
         ChatBar.instance.hide();
         ResourcesBar.instance.hide();
         SmallMapBar.instance.hide();
         TaskTraceBar.instance.hide();
         QueueBar.instance.hide();
         ShowTipManager.Instance.removeCurrentTip();
         BagHelper.instance.stopSelling();
         TaskTraceTipManager.instance.cleanByType(19);
         TaskTraceTipManager.instance.cleanByType(14);
         TaskTraceTipManager.instance.cleanByType(41);
         LayerManager.Instance.cleanLayerByType(3);
      }
      
      private function end() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         MarryManager.instance.model.lockScreen = false;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_FREEDOMTEAMLIST",false));
         stop();
         if(WorldBossHelper.checkWedding(CampaignManager.instance.mapId))
         {
            SmallMapBar.instance.hide();
            QueueBar.instance.hide();
            TaskTraceBar.instance.hide();
         }
         else
         {
            SmallMapBar.instance.show();
            QueueBar.instance.show();
            TaskTraceBar.instance.show();
         }
         TopToolsBar.instance.show();
         MainToolBar.instance.show();
         TipsBar.instance.show();
         FullBar.instance.show();
         ChatBar.instance.show();
         ResourcesBar.instance.show();
         ChatBar.instance.chatOutPutView.cleanBtn.alpha = 1;
         ChatBar.instance.upBtn.alpha = 1;
         ChatBar.instance.downBtn.alpha = 1;
         ChatBar.instance.buttonBox.alpha = 1;
         ChatBar.instance.buttonBox.x = 7;
         ChatBar.instance.chatOutPutView.back.alpha = 1;
         ChatBar.instance.chatOutPutView.chatList.vScrollbar.alpha = 1;
         ChatBar.instance.chatOutPutView.toBottomBtn.alpha = 1;
      }
      
      private function stop() : void
      {
         TweenMax.killTweensOf(ChatBar.instance.buttonBox);
         TweenMax.killTweensOf(ChatBar.instance.chatOutPutView.cleanBtn);
         TweenMax.killTweensOf(ChatBar.instance.chatOutPutView.back);
         TweenMax.killTweensOf(ChatBar.instance.chatOutPutView.chatList.vScrollbar);
         TweenMax.killTweensOf(ChatBar.instance.chatOutPutView.toBottomBtn);
      }
      
      public function dispose() : void
      {
         removeEvent();
         end();
         if(_isDie == false)
         {
            if(ChatBar.instance.isMinShow)
            {
               if(_output)
               {
                  _output.showMinView();
               }
            }
            else if(_output)
            {
               _output.showMaxView();
            }
            _bugleView = null;
            _input = null;
            _output = null;
         }
         if(_whiteBg)
         {
            _whiteBg.graphics.clear();
            if(_whiteBg.parent)
            {
               _whiteBg.parent.removeChild(_whiteBg);
            }
            _whiteBg = null;
         }
         if(_flowerBg)
         {
            _flowerBg.dispose();
         }
         _flowerBg = null;
         if(_bottomBg)
         {
            _bottomBg.dispose();
         }
         _bottomBg = null;
         if(_leftImage)
         {
            _leftImage.dispose();
         }
         _leftImage = null;
         if(_rightImage1)
         {
            _rightImage1.dispose();
         }
         _rightImage1 = null;
         if(_rightImage2)
         {
            _rightImage2.dispose();
         }
         _rightImage2 = null;
         if(_dialogWordView)
         {
            _dialogWordView.dispose();
         }
         _dialogWordView = null;
         ObjectUtils.disposeObject(angelImage1);
         angelImage1 = null;
         ObjectUtils.disposeObject(angelImage2);
         angelImage2 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _isDie = true;
         _outputRect = null;
      }
   }
}

