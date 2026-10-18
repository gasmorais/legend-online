package map.campaign.view.physics
{
   import avatar.data.AvatarStaticData;
   import avatar.view.HeroAvatar;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.MarketModel;
   import map.campaign.view.market.MarketBuyFrame;
   import map.internals.data.ArmyChildrenInfo;
   import map.internals.data.ArmyMonsterInfo;
   import map.internals.data.ArmyPetInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   
   public class MarketArmyView extends PetLandArmyView
   {
      
      private var _stallBtn:TextButton;
      
      private var _buyFrame:MarketBuyFrame;
      
      public function MarketArmyView()
      {
         super();
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         if(_data)
         {
            _data.addEventListener("IS_SELLING",__changeSellHandler);
         }
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         if(_data)
         {
            _data.removeEventListener("IS_SELLING",__changeSellHandler);
         }
         if(_stallBtn)
         {
            _stallBtn.removeEventListener("click",__stallBtnHandler);
         }
      }
      
      override public function set data(param1:CampaignArmy) : void
      {
         super.data = param1;
         __changeSellHandler(null);
      }
      
      private function __changeSellHandler(param1:Event) : void
      {
         if(_data)
         {
            showChildren(_data.childrenInfo);
            showPet(_data.petInfo);
            if(VersionSwitch.MONSTER_FOLLOW)
            {
               showMonster(_data.monsterInfo);
            }
            showAvatar(_data);
            showHoner();
            refreshVocation();
            showSellBtn();
         }
      }
      
      private function showSellBtn() : void
      {
         if(_data && _data.sellState == 2)
         {
            if(_stallBtn == null)
            {
               _stallBtn = ComponentFactory.Instance.creatComponentByStylename("CampaignMarketView.StallBtn");
               _stallBtn.text = data.stallName;
               _stallBtn.addEventListener("click",__stallBtnHandler);
               addChild(_stallBtn);
               layoutTxtViewWithNamePosY();
            }
         }
         else if(_stallBtn)
         {
            _stallBtn.removeEventListener("click",__stallBtnHandler);
            _stallBtn.dispose();
            _stallBtn = null;
         }
      }
      
      override protected function showAvatar(param1:CampaignArmy) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc2_:Object = null;
         if(_data && _data.sellState == 2)
         {
            _loc3_ = JobType.getDefaultBodyEquipNameByJob(100);
            if(!avatarView)
            {
               avatarView = new HeroAvatar(true,_loc3_,2,0,isSelf,100);
            }
            avatarView.type = 2;
            avatarView.removeAllAvatar();
            _loc4_ = isSelf ? 10 : 4;
            _loc5_ = PathManager.resourcePath + _loc3_;
            _loc2_ = createResourceLoadInfo(_loc5_,AvatarStaticData.BASE_NPC_STAND,AvatarStaticData.BASE_NPC_WALK,"body");
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
            LoaderManagerII.instance.load(_loc5_,4,_loc4_,loaderCompleteHandler,null,null,_loc2_);
            return;
         }
         if(avatarView)
         {
            avatarView.removeAvatar("body");
         }
         super.showAvatar(param1);
      }
      
      override public function showFateSkillEffect() : void
      {
      }
      
      override protected function showHoner() : void
      {
         if(_data && _data.sellState == 2)
         {
            if(_honerTxt && _honerTxt.parent)
            {
               _honerTxt.parent.removeChild(_honerTxt);
            }
            if(_honerView && _honerView.parent)
            {
               _honerView.parent.removeChild(_honerView);
            }
         }
         else
         {
            super.showHoner();
         }
      }
      
      override protected function refreshVocation() : void
      {
         if(_data && _data.sellState == 2)
         {
            _vocationIcon.visible = false;
            if(_avengerEffect)
            {
               _avengerEffect.visible = false;
            }
         }
         else
         {
            super.refreshVocation();
         }
      }
      
      override protected function showPet(param1:ArmyPetInfo) : void
      {
         if(_data && _data.sellState == 2)
         {
            if(_petAvatarView)
            {
               _petAvatarView.dispose();
               _petAvatarView = null;
            }
         }
         else
         {
            super.showPet(param1);
         }
      }
      
      override protected function showMonster(param1:ArmyMonsterInfo) : void
      {
         if(_data && _data.sellState == 2)
         {
            if(_monsterAvatarView)
            {
               _monsterAvatarView.dispose();
               _monsterAvatarView = null;
            }
         }
         else
         {
            super.showMonster(param1);
         }
      }
      
      override protected function showChildren(param1:ArmyChildrenInfo) : void
      {
         if(_data && _data.sellState == 2)
         {
            if(_childrenAvatarView)
            {
               _childrenAvatarView.dispose();
               _childrenAvatarView = null;
            }
         }
         else
         {
            super.showChildren(param1);
         }
      }
      
      override protected function layoutTxtViewWithNamePosY() : void
      {
         var _loc1_:ThaneInfo = null;
         super.layoutTxtViewWithNamePosY();
         if(_stallBtn)
         {
            if(isSelf)
            {
               _loc1_ = thane;
            }
            else
            {
               _loc1_ = _data.baseHero;
            }
            _stallBtn.x = -_stallBtn.width / 2;
            if(consortiaName)
            {
               _stallBtn.y = _showNamePosY - _stallBtn.height - 20;
            }
            else
            {
               _stallBtn.y = _showNamePosY - _stallBtn.height;
            }
         }
      }
      
      override public function mouseHitTest() : Boolean
      {
         var _loc1_:Boolean = super.mouseHitTest();
         if(onStallBtn)
         {
            _loc1_ = true;
         }
         return _loc1_ && _data && _data.sellState == 2;
      }
      
      override public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         PlayerManager.instance.currentPlayerModel.selectTarget = data;
         param1.stopPropagation();
         if(_data && _data.sellState == 2)
         {
            if(marketModel.stalls[_data.userId])
            {
               controller.moveArmyByPos(_data.curPosX * 20,_data.curPosY * 20,false,false);
            }
         }
         return true;
      }
      
      override public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         if(_data == null || _data.sellState != 2)
         {
            return false;
         }
         if(isSelf)
         {
            this.buttonMode = false;
            this.mouseChildren = this.mouseEnabled = false;
            return false;
         }
         if(_avatar)
         {
            if((_avatar as HeroAvatar).getCurrentPixels() > 50 || onStallBtn)
            {
               if(_stallBtn)
               {
                  _stallBtn.setFrame(2);
               }
               _filter.setGlowFilter(_avatar);
            }
            else
            {
               if(_stallBtn)
               {
                  _stallBtn.setFrame(1);
               }
               _filter.setNormalFilter(_avatar);
               if(param1)
               {
                  throughDispatch(param1);
               }
            }
         }
         return false;
      }
      
      public function get onStallBtn() : Boolean
      {
         return _stallBtn && _stallBtn.mouseX > 0 && _stallBtn.mouseX < _stallBtn.width && _stallBtn.mouseY > 0 && _stallBtn.mouseY < _stallBtn.height;
      }
      
      override public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         if(_stallBtn)
         {
            _stallBtn.setFrame(1);
         }
         return super.mouseOutHandler(param1);
      }
      
      protected function __stallBtnHandler(param1:MouseEvent) : void
      {
         if(_data && _data.sellState == 2)
         {
            marketModel.lookStall(_data.userId);
         }
      }
      
      private function lookUpStall() : void
      {
         if(_buyFrame && !_buyFrame.isDie)
         {
            _buyFrame.dispose();
         }
         _buyFrame = ComponentFactory.Instance.creatComponentByStylename("market.MarketBuyFrame");
         _buyFrame.show();
      }
      
      private function get marketModel() : MarketModel
      {
         return CampaignManager.instance.marketModel;
      }
      
      private function get controller() : *
      {
         return CampaignManager.instance.controller;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_stallBtn)
         {
            _stallBtn.dispose();
         }
         _stallBtn = null;
      }
   }
}

